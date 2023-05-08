package com.a101.fakediary.diary.service;

import com.a101.fakediary.card.dto.response.CardMadeDiaryResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.carddiarymapping.service.CardDiaryMappingService;
import com.a101.fakediary.diary.dto.*;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryQueryRepository;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.diaryimage.repository.DiaryImageRepository;
import com.a101.fakediary.diaryimage.service.DiaryImageService;
import com.a101.fakediary.enums.EGenre;
import com.a101.fakediary.genre.dto.GenreDto;
import com.a101.fakediary.genre.service.GenreService;
import com.a101.fakediary.member.repository.MemberRepository;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.ExchangeStrategies;
import org.springframework.web.reactive.function.client.WebClient;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
@Transactional
@RequiredArgsConstructor
public class DiaryService {

    private final DiaryRepository diaryRepository;
    private final MemberRepository memberRepository;
    private final GenreService genreService;
    private final DiaryRepository diaryImageRepository;
    private final CardDiaryMappingService cardDiaryMappingService;
    private final CardRepository cardRepository;
    private final DiaryImageService diaryImageService;
    private final DiaryQueryRepository diaryQueryRepository;
    private final PapagoTranslator papagoTranslator;
    private static final Logger logger = LoggerFactory.getLogger(DiaryService.class);

    //aws credentials key
    @Value("${cloud.aws.credentials.access-key}")
    private String accessKey;

    @Value("${cloud.aws.credentials.secret-key}")
    private String secretKey;

    //  버킷
    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    // stable diffusion 서버 url 매일 달라짐 수동으로 수정 필요
    private String stableDiffusionURL = "https://f44ca12b95ab.ngrok.app"; //230508

    private Diary toEntity(DiaryRequestDto dto) {
        return Diary.builder()
                .member(memberRepository.findByMemberId(dto.getMemberId()))
                .keyword(dto.getKeyword()) // 받아온 카드리스트기반으로 키워드 추출
                .characters(dto.getCharacters())
                .places(dto.getPlaces())
                .prompt(dto.getPrompt()) //프론트GPT
                .title(dto.getTitle()) //프론트GPT
                .detail(dto.getDetail()) //프론트GPT
                .summary(dto.getSummary()) //프론트GPT
                .build();
    }

    private List<DiaryResponseDto> changeResponse(List<Diary> diary) {
        List<DiaryResponseDto> list = new ArrayList<>();
        for (Diary value : diary) {
            DiaryResponseDto tmp = new DiaryResponseDto(value);
            List<String> genre = genreService.searchGenre(tmp.getDiaryId());
            EGenre[] eGenres = new EGenre[genre.size()];
            int i = 0;
            for (String s : genre)
                eGenres[i++] = EGenre.valueOf(s);
            tmp.setGenre(eGenres);
            tmp.setDiaryImageUrl(diaryImageService.readDiaryImages(value.getDiaryId()));
            list.add(tmp);
        }
        return list;
    }

    private DiaryResponseDto changeResponse(Diary diary) {
        DiaryResponseDto tmp = new DiaryResponseDto(diary);
        List<String> genre = genreService.searchGenre(tmp.getDiaryId());
        EGenre[] eGenres = new EGenre[genre.size()];
        int i = 0;
        for (String s : genre)
            eGenres[i++] = EGenre.valueOf(s);
        tmp.setGenre(eGenres);
        tmp.setDiaryImageUrl(diaryImageService.readDiaryImages(diary.getDiaryId()));
        return tmp;
    }

    @Transactional
    public Diary createDiary(DiaryRequestDto dto) throws Exception {
        //dto 키워드+ 채우기
        StringBuilder keywords = new StringBuilder();
        StringBuilder names = new StringBuilder();
        StringBuilder places = new StringBuilder();

        List<Long> cardIds = dto.getCardIds();
        for (Long id : cardIds) {
            Card card = cardRepository.findById(id).orElseThrow();
            //빈것보냈을때 null로저장되는지 ""로저장되는지 확인필요 값이 존재하면 이어줌
            if (card.getKeyword() != null && !card.getKeyword().equals(""))
                keywords.append(card.getKeyword()).append("@"); //키워드@키워드@키워드@ 식으로 제작
            if (card.getBaseName() != null && !card.getBaseName().equals(""))
                names.append(card.getBaseName()).append("@");
            if (card.getBasePlace() != null && !card.getBasePlace().equals(""))
                places.append(card.getBasePlace()).append("@");
        }

        if (0 < keywords.length() && keywords.charAt(keywords.length() - 1) == '@') {
            keywords.deleteCharAt(keywords.length() - 1); // 마지막 골뱅이 제거
        }
        if (0 < names.length() && names.charAt(names.length() - 1) == '@') {
            names.deleteCharAt(names.length() - 1);
        }
        if (0 < places.length() && places.charAt(places.length() - 1) == '@') {
            places.deleteCharAt(places.length() - 1);
        }
        dto.setKeyword(keywords.toString());
        dto.setCharacters(names.toString());
        dto.setPlaces(places.toString());
        //dto 키워드 채우기 end

        //GPT API날려서 dto에 GPT관련 내용채우기

        if(dto.getCharacters().equals("") && dto.getPlaces().equals("") && dto.getKeyword().equals(""))
            throw new Exception("주인공,장소, 키워드 모두 존재하지 않음");

        //일기 생성
        Diary diary = diaryRepository.save(toEntity(dto));

//        검증 로직 일기생성전 처리하게 변경 문제없을시 아래코드삭제
//        if(diary.getCharacters().equals("") && diary.getPlaces().equals("") && diary.getKeyword().equals(""))
//            throw new Exception("주인공, 장소, 키워드 모두 존재하지 않음");

        //장르 테이블 생성
        List<String> genreList = dto.getGenre();

        for (String genre : genreList) {
            GenreDto gen = new GenreDto(diary.getDiaryId(), genre);
            genreService.saveGenre(gen); //장르 저장
        }

        // 카드&일기 매핑테이블 생성
        cardDiaryMappingService.createCardDiaryMappings(diary.getDiaryId(), cardIds);

        //stable diffusion 활용하여 썸네일 생성
        //webClient 최대 버퍼 크기 128MB로 설정
        ExchangeStrategies exchangeStrategies = ExchangeStrategies.builder()
                .codecs(configurer -> configurer.defaultCodecs().maxInMemorySize(1024 * 1024 * 128))
                .build();

        WebClient webClient = WebClient.builder()
                .exchangeStrategies(exchangeStrategies)
                .build();

        Map<String, Object> map = new HashMap<>();
        //중요한것은 prompt, steps, sampler_index
        map.put("prompt", translate(dto.getTitle()));
        map.put("steps", 20);
        map.put("sampler_index", "Euler a");
        map.put("enable_hr", false);
        map.put("denoising_strength", 0);
        map.put("firstphase_width", 0);
        map.put("firstphase_height", 0);
        map.put("hr_scale", 2);
        map.put("hr_upscaler", "");
        map.put("hr_second_pass_steps", 0);
        map.put("hr_resize_x", 0);
        map.put("hr_resize_y", 0);
        map.put("styles", new ArrayList<>());
        map.put("seed", -1);
        map.put("subseed", -1);
        map.put("subseed_strength", 0);
        map.put("seed_resize_from_h", -1);
        map.put("seed_resize_from_w", -1);
        map.put("sampler_name", "");
        map.put("batch_size", 1);
        map.put("n_iter", 1);
        map.put("cfg_scale", 7);
        map.put("width", 512);
        map.put("height", 512);
        map.put("restore_faces", false);
        map.put("tiling", false);
        map.put("do_not_save_samples", false);
        map.put("do_not_save_grid", false);
        map.put("negative_prompt", "");
        map.put("eta", 0);
        map.put("s_churn", 0);
        map.put("s_tmax", 0);
        map.put("s_tmin", 0);
        map.put("s_noise", 1);
        map.put("override_settings", new HashMap<>());
        map.put("override_settings_restore_afterwards", true);
        map.put("script_args", new ArrayList<>());
        map.put("script_name", "");
        map.put("send_images", true);
        map.put("save_images", false);
        map.put("alwayson_scripts", new HashMap<>());


        AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
        AmazonS3 s3client = new AmazonS3Client(credentials);

        String key = "image-" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss")) + ".png";


        ClientResponse response = webClient.post()
                .uri(stableDiffusionURL+"/sdapi/v1/txt2img")//매일매일 주소 바뀜
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(map)
                .exchange()
                .block();

        ObjectMapper objectMapper = new ObjectMapper();
        String stableDiffusionThumbnailUrl;
        if (response.statusCode().equals(HttpStatus.OK)) {//200응답
            String responseBody = response.bodyToMono(String.class).block();
            StableDiffusion200ResponseDto response200Dto = objectMapper.readValue(responseBody, StableDiffusion200ResponseDto.class);
            String imageData = response200Dto.getImages().get(0);
            byte[] decodedImg = Base64.getDecoder().decode(imageData.getBytes("UTF-8"));
            Path destinationFile = Paths.get("image.png");
            Files.write(destinationFile, decodedImg);

            // S3에 업로드
            s3client.putObject(bucket, key, destinationFile.toFile());

            // 이미지 url얻고
            stableDiffusionThumbnailUrl = s3client.getUrl(bucket, key).toString();

            List<String> dtoImageUrl = new ArrayList<>();
            dtoImageUrl.add(stableDiffusionThumbnailUrl);
            dto.setDiaryImageUrl(dtoImageUrl);


        } else if (response.statusCode().equals(HttpStatus.UNPROCESSABLE_ENTITY)) { //422응답
            String responseBody = response.bodyToMono(String.class).block();
            StableDiffusion422ResponseDto response422Dto = objectMapper.readValue(responseBody, StableDiffusion422ResponseDto.class);
        } else {
            throw new Exception("Stable Diffusion Exception");
        }
        //-- end stable diffusion 활용하여 썸네일 생성 end--

        //일기&이미지파일 테이블 만들기 현재 썸네일만 있는 상태
        diaryImageService.createDiaryImages(diary.getDiaryId(), dto.getDiaryImageUrl());

        return diary;
    }

    @Transactional(readOnly = true)
    public DiaryResponseDto detailDiary(Long diaryId) {
        return changeResponse(diaryRepository.findByDiaryId(diaryId));
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> allDiary(Long memberId) {
        List<Diary> diary = diaryRepository.allDiary(memberId);
        return changeResponse(diary);
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> filterDiary(DiaryFilterDto filter) {//선택한 memberId, 요청한 memberId, 장르
        List<Diary> diary = diaryQueryRepository.searchDiaryByFilter(filter);
        return changeResponse(diary);
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> getDevelopersDiaries() {
        return diaryRepository.getDevelopersDiaries();
    }

    @Transactional
    public void deleteDiary(Long diaryId) {
        genreService.deleteGenre(diaryId);
        diaryRepository.deleteDiary(diaryId);
    }

    //카드Id리스트로부터 만들어진 다이어리 리스트 반환
    @Transactional(readOnly = true)
    public List<CardMadeDiaryResponseDto> findDiaryListFromCardList(List<Long> diaryIdList) {
        List<CardMadeDiaryResponseDto> returnList = new ArrayList<CardMadeDiaryResponseDto>();
        for (Long diaryId : diaryIdList) {
            Diary diary = diaryRepository.findByDiaryId(diaryId);
            List<String> diaryImageUrls = diaryImageRepository.findDiaryImageUrlByDiaryId(diaryId);
            String diaryThumbnail = diaryImageUrls.stream().findFirst().orElse("이미지가 없습니다.");//썸네일
            CardMadeDiaryResponseDto dto = new CardMadeDiaryResponseDto().builder()
                    .diaryId(diary.getDiaryId())
                    .title((diary.getTitle()))
                    .subtitles(diary.getSubtitles())
                    .summary(diary.getSummary())
                    .diaryImageUrl(diaryThumbnail)
                    .characters(diary.getCharacters())
                    .places(diary.getPlaces())
                    .keyword(diary.getKeyword())
                    .createdAt(diary.getCreatedAt())
                    .build();
            returnList.add(dto);
        }
        return returnList;
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> getDiariesByCardId(Long cardId) throws Exception {
        List<Diary> diaries = diaryRepository.findDiariesByCardId(cardId).orElseThrow(() -> new Exception("cardId에 해당하는 일기 존재하지 않음"));
        List<DiaryResponseDto> ret = new ArrayList<>();

        for(Diary diary : diaries)
            ret.add(new DiaryResponseDto(diary));

        return ret;
    }

    @Async
    public String translate(String text) { //메소드 불러서 바꾸고 싶은 내용 text에 넣으면 한 -> 영 바꿔서 return
        String translatedText = papagoTranslator.translate(text).block();
        Pattern pattern = Pattern.compile("\"translatedText\":\"([^\"]*)\"");
        Matcher matcher = pattern.matcher(translatedText);
        if (matcher.find()) {
            String trans = matcher.group(1);
            logger.info("번역할 언어 : {}", text);
            logger.info("번역된 언어 : {}", trans);
            return trans;
        }
        return null;
    }
}