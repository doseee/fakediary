package com.a101.fakediary.diary.service;

import com.a101.fakediary.alarm.dto.AlarmRequestDto;
import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.alarm.service.AlarmService;
import com.a101.fakediary.card.dto.response.CardMadeDiaryResponseDto;
import com.a101.fakediary.card.dto.response.CardSaveResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.carddiarymapping.service.CardDiaryMappingService;
import com.a101.fakediary.chatgptdiary.api.ChatGptApi;
import com.a101.fakediary.chatgptdiary.dto.message.Message;
import com.a101.fakediary.chatgptdiary.dto.result.DiaryResultDto;
import com.a101.fakediary.chatgptdiary.dto.result.TitleSubtitlesResultDto;
import com.a101.fakediary.chatgptdiary.prompt.ChatGptPrompts;
import com.a101.fakediary.diary.dto.DiaryItemsDto;
import com.a101.fakediary.diary.dto.DiaryFilterDto;
import com.a101.fakediary.diary.dto.DiaryRequestDto;
import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryQueryRepository;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.diaryimage.service.DiaryImageService;
import com.a101.fakediary.enums.EGenre;
import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.friendexchangerequest.repository.FriendExchangeRequestRepository;
import com.a101.fakediary.genre.dto.GenreDto;
import com.a101.fakediary.genre.service.GenreService;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.a101.fakediary.randomexchangepool.repository.RandomExchangePoolRepository;
import com.a101.fakediary.stablediffusion.api.StableDiffusionApi;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.time.*;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
@Transactional
@RequiredArgsConstructor
public class DiaryService {
    private final DiaryRepository diaryRepository;
    private final MemberRepository memberRepository;
    private final GenreService genreService;
    private final CardDiaryMappingService cardDiaryMappingService;
    private final CardRepository cardRepository;
    private final DiaryImageService diaryImageService;
    private final DiaryQueryRepository diaryQueryRepository;
    //    private final PapagoTranslator papagoTranslator;
    private final ChatGptApi chatGptApi;
    private final StableDiffusionApi stableDiffusionApi;
    private final FriendExchangeRequestRepository friendExchangeRequestRepository;
    private final RandomExchangePoolRepository randomExchangePoolRepository;
    private final AlarmService alarmService;
    private static final Logger logger = LoggerFactory.getLogger(DiaryService.class);

    private final static String DELIMITER = "@";

    //aws credentials key
    @Value("${cloud.aws.credentials.access-key}")
    private String accessKey;

    @Value("${cloud.aws.credentials.secret-key}")
    private String secretKey;

    //  버킷
    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

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
                .subtitles(dto.getSubtitles())
                .build();
    }

    public List<DiaryResponseDto> changeResponse(List<Diary> diary) {
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

    //삭제되지 않은 다이어리 단일 조회
    @Transactional(readOnly = true)
    public Diary findNotDeletedDiaryById(Long diaryId) throws Exception {
        Diary diary = diaryRepository.findById(diaryId).orElseThrow(() -> new Exception("다이어리Id가 존재하지 않습니다."));
        if (diary.isDeleted()) {
            throw new Exception("삭제된 다이어리입니다.");
        }
        return diary;
    }

    @Transactional(readOnly = true)
    public DiaryResponseDto detailDiary(Long diaryId) {
        return changeResponse(diaryRepository.findById(diaryId).get());
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> allDiary(Long memberId) {
        List<Diary> diary = diaryRepository.findByMember_MemberIdAndIsDeletedFalseOrderByDiaryIdDesc(memberId);
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
    public void deleteStatusDiary(Long diaryId) throws Exception {
        Diary diary = diaryRepository.findById(diaryId).orElseThrow();

        if (diary.isDeleted()) {
            throw new Exception("이미 삭제 상태로 변경된 일기입니다.");
        }
        //이 diaryId가 friendExchangeRequest에 존재하고, status가 WAITING이면(친구와 교환중인상태) 들어가있으면 삭제불가
        if (friendExchangeRequestRepository.findBySenderDiary_DiaryIdAndStatus(diaryId, ERequestStatus.WAITING) != null) {
            throw new Exception("친구와 교환 대기중인 일기는 삭제가 불가능합니다.");
        }
        //diaryId가 randomExchangePool테이블의 sender_id가 존재하고 updated_at이 null이 아니라면(매칭중인상태) 삭제 불가
        if (randomExchangePoolRepository.findByDiary_DiaryIdAndUpdatedAtNotNull(diaryId) != null) {
            throw new Exception("랜덤 교환중인 일기는 삭제가 불가능합니다.");
        }
        diary.setDeleted(true);
    }

    @Transactional
    public void deleteDiary(Long diaryId) {
        genreService.deleteGenre(diaryId);
        diaryRepository.deleteDiary(diaryId);
    }

    //카드Id리스트로부터 만들어진 일기 리스트 반환
    @Transactional(readOnly = true)
    public List<CardMadeDiaryResponseDto> findDiaryListFromCardList(List<Long> diaryIdList) throws Exception {
        List<CardMadeDiaryResponseDto> returnList = new ArrayList<>();
        for (Long diaryId : diaryIdList) {
            Diary diary = diaryRepository.findById(diaryId).orElseThrow();
            if (diary.isDeleted())
                continue;
            List<String> diaryImageUrls = diaryRepository.findDiaryImageUrlByDiaryId(diaryId);
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
                    .isDeleted(diary.isDeleted())
                    .build();
            returnList.add(dto);
        }
        return returnList;
    }

    @Transactional
    public void setAllDiariesRandomExchangedUnused() {
        List<Diary> allDiaries = diaryRepository.findAll();
        for (Diary diary : allDiaries)
            diary.setExchanged(false);
    }

    @Transactional(readOnly = true)
    public DiaryItemsDto getItemInformations(List<Long> cardList, List<String> genreList) throws Exception {
        List<String> characters = new ArrayList<>();
        List<String> places = new ArrayList<>();
        List<String> keywords = new ArrayList<>();

        Set<String> charactersSet = new HashSet<>();
        Set<String> placesSet = new HashSet<>();
        Set<String> keywordsSet = new HashSet<>();  //  중복 키워드를 제거하기 위한 과정

        for (Long cardPk : cardList) {
            Card card = cardRepository.findById(cardPk).orElseThrow(() -> new Exception("cardList에 저장된 카드 PK와 일치하는 카드가 없음"));
            CardSaveResponseDto dto = CardSaveResponseDto.getCardSaveResponseDto(card);

            String baseName = dto.getBaseName();
            String basePlace = dto.getBasePlace();
            List<String> keywordList = dto.getKeywords();

            if (baseName != null && !baseName.equals("") && !charactersSet.contains(baseName)) { //  카드에 등장인물이 존재하고 중복되지 않을 경우
                characters.add(baseName);
                charactersSet.add(baseName);
            }
            if (basePlace != null && !basePlace.equals("") && !placesSet.contains(basePlace)) {    //  카드에 장소가 존재하고 장소가 중복되지 않을 경우
                places.add(basePlace);
                placesSet.add(basePlace);
            }
            if (dto.getKeywords() != null && !dto.getKeywords().isEmpty()) {   //  카드에 키워드 리스트가 존재하는 경우
                for (String keyword : keywordList) {
                    if (!keywordsSet.contains(keyword)) {    //  키워드가 중복되지 않을 경우
                        keywords.add(keyword);
                        keywordsSet.add(keyword);
                    }
                }
            }
        }

        return DiaryItemsDto.builder()
                .characters(characters)
                .places(places)
                .keywords(keywords)
                .genres(genreList)
                .build();
    }

    @Transactional(readOnly = true)
    public DiaryResultDto getResultDto(List<Long> cardList, List<String> genres) throws Exception {
        DiaryItemsDto diaryItemsDto = getItemInformations(cardList, genres);
        List<String> characters = diaryItemsDto.getCharacters();
        List<String> places = diaryItemsDto.getPlaces();
        List<String> keywords = diaryItemsDto.getKeywords();

        String prompt = ChatGptPrompts.generateUserPrompt(characters, places, keywords, genres);

//        TitleSubtitlesResultDto titleSubtitlesResultDto = chatGptApi.askGpt4TitleSubtitles(prompt);
//        logger.info("titleSubtitlesResultDto = " + titleSubtitlesResultDto);
        List<Message> messageList = chatGptApi.askGpt41(new ArrayList<Message>(), prompt);  //  GPT4 사용 시 askGpt4로 변경

        StringBuilder diaryContent = new StringBuilder();
        for (Message message : messageList) {
            String role = message.getRole();
            String content = message.getContent();

            if (role.equals("assistant")) {
                diaryContent.append(content);
            }
        }

        logger.info("diaryContent = " + diaryContent);

        ObjectMapper objectMapper = new ObjectMapper();
        DiaryResultDto diaryResultDto = objectMapper.readValue(diaryContent.toString(), DiaryResultDto.class);
        diaryResultDto.setPrompt(prompt);

        return diaryResultDto;
    }

    @Transactional
    public DiaryResponseDto createDiary(Long memberId, List<Long> cardIdList, List<String> genreList) throws Exception {
        logger.info(memberId + "번 MemberId의 일기 생성을 시작하겠습니다.");
        // 메소드 시작시간
        long startTime = System.nanoTime();

        DiaryResultDto diaryResultDto = getResultDto(cardIdList, genreList);

        String title = diaryResultDto.getTitle();
        String summary = diaryResultDto.getSummary();
        List<String> subtitleList = diaryResultDto.getSubtitles();
        List<String> contents = diaryResultDto.getContents();
        String prompt = diaryResultDto.getPrompt();
        Member member = memberRepository.findById(memberId).orElseThrow(() -> new Exception("찾으려는 회원이 존재하지 않음."));

        logger.info("subtitleList = " + subtitleList);

        Map<String, String> map = getDiaryItems(cardIdList);
        String keywords = map.getOrDefault("keywords", "");
        String characters = map.getOrDefault("characters", "");
        String places = map.getOrDefault("places", "");

        StringBuilder sb = new StringBuilder();

        for (String content : contents)
            sb.append(content).append(DELIMITER);
        if (sb.charAt(sb.length() - 1) == '@')
            sb.deleteCharAt(sb.lastIndexOf("@"));
        String detail = sb.toString().trim();

        sb = new StringBuilder();

        for (String subtitle : subtitleList) {
            sb.append(subtitle).append(DELIMITER);
        }

        if (0 < sb.length() && sb.toString().endsWith(DELIMITER))
            sb.setLength(sb.length() - 1);

        String subtitles = sb.toString();
        logger.info("subtitles = " + subtitles);

        Diary diary = Diary.builder()
                .member(member)
                .characters(characters)
                .places(places)
                .keyword(keywords)
                .prompt(prompt)
                .title(title)
                .subtitles(subtitles)
                .detail(detail)
                .summary(summary)
                .build();

        Long diaryId = diaryRepository.save(diary).getDiaryId();

        for (String genre : genreList) {
            GenreDto gen = new GenreDto(diary.getDiaryId(), genre);
            genreService.saveGenre(gen); //장르 저장
        }

        // 카드&일기 매핑테이블 생성
        cardDiaryMappingService.createCardDiaryMappings(diary.getDiaryId(), cardIdList);

        Map<String, Object> stableDiffusionMap = stableDiffusionApi.getStableDiffusionUrlsAndPrompt(title, subtitleList);
        List<String> stableDiffusionUrls = (List<String>) stableDiffusionMap.get("stableDiffusionUrl");
        logger.info("stableDiffusionUrls = " + stableDiffusionUrls);
        List<String> diaryImagePrompt = (List<String>) stableDiffusionMap.get("diaryImagePrompt");
        logger.info("diaryImagePrompt = " + diaryImagePrompt);
        diaryImageService.createDiaryImages(diaryId, stableDiffusionUrls, diaryImagePrompt);

        DiaryResponseDto returnDto = new DiaryResponseDto(diary);
        List<String> genres = genreService.searchGenre(diary.getDiaryId());
        EGenre[] genreArray = genres.stream()
                .map(EGenre::valueOf)
                .toArray(EGenre[]::new);
        returnDto.setGenre(genreArray);
        returnDto.setDiaryImageUrl(stableDiffusionUrls.toArray(new String[stableDiffusionUrls.size()]));

        // 메소드 종료 시간
        long endTime = System.nanoTime();

        // 소요된 시간 (초 단위)
        double elapsedTime = (endTime - startTime) / 1_000_000_000.0;

        // 일기 생성에 소요된 시간을 로그로 출력
        logger.info(memberId + "(" + member.getNickname() + ")" + "번 memberId의 " + diaryId + "번 diaryId 일기를 만드는데 소요된 시간 : {} 초", elapsedTime);
        return returnDto;
    }

    /**
     * @param cardIdList : 일기에 사용될 카드 PK 리스트
     * @return : 카드들에서 중복 없이 등장인물 문자열, 장소 문자열, 키워드 문자열을 만듬
     */
    private Map<String, String> getDiaryItems(List<Long> cardIdList) {
        StringBuilder keywords = new StringBuilder();
        StringBuilder characters = new StringBuilder();
        StringBuilder places = new StringBuilder();
        Map<String, String> map = new HashMap<>();

        Set<String> keywordsMap = new HashSet<>();
        Set<String> charactersMap = new HashSet<>();
        Set<String> placesMap = new HashSet<>();

        for (Long id : cardIdList) {
            Card card = cardRepository.findById(id).orElseThrow();

            if (card.getKeyword() != null && !card.getKeyword().equals("")) {
                StringTokenizer keywordTokens = new StringTokenizer(card.getKeyword(), DELIMITER);
                while (keywordTokens.hasMoreTokens()) {
                    String keyword = keywordTokens.nextToken();

                    if (!keywordsMap.contains(keyword)) {
                        keywords.append(keyword).append(DELIMITER);
                        keywordsMap.add(keyword);
                    }
                }
            }

            if (card.getBaseName() != null && !card.getBaseName().equals("")) {
                StringTokenizer baseNameTokens = new StringTokenizer(card.getBaseName(), DELIMITER);
                while (baseNameTokens.hasMoreTokens()) {
                    String baseName = baseNameTokens.nextToken();

                    if (!charactersMap.contains(baseName)) {
                        characters.append(baseName).append(DELIMITER);
                        charactersMap.add(baseName);
                    }
                }
            }

            if (card.getBasePlace() != null && !card.getBasePlace().equals("")) {
                StringTokenizer basePlacesTokens = new StringTokenizer(card.getBasePlace(), DELIMITER);
                while (basePlacesTokens.hasMoreTokens()) {
                    String basePlace = basePlacesTokens.nextToken();

                    if (!placesMap.contains(basePlace)) {
                        places.append(basePlace).append(DELIMITER);
                        placesMap.add(basePlace);
                    }
                }
            }
        }

        //마지막 골뱅이 제거
        if (0 < keywords.length() && keywords.toString().endsWith(DELIMITER))
            keywords.setLength(keywords.length() - 1);
        if (0 < characters.length() && characters.toString().endsWith(DELIMITER))
            characters.setLength(characters.length() - 1);
        if (0 < places.length() && places.toString().endsWith(DELIMITER))
            places.setLength(places.length() - 1);

        map.put("keywords", keywords.toString());
        map.put("characters", characters.toString());
        map.put("places", places.toString());

        return map;
    }

    @Async
    //유저가 정해둔 시간에 맞춰 일기 자동생성하기
    @Scheduled(cron = "0 0/30 * * * ?", zone = "Asia/Seoul") // 현재 30분 기준으로 생성중
    @Transactional(propagation = Propagation.NOT_SUPPORTED)//트랜잭셔널 해제해서 유저별로 바로바로 일기생성되도록함
    public void createAutoDiary() throws Exception {
        LocalTime now = LocalTime.now(ZoneId.of("Asia/Seoul"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        String formattedTime = now.format(formatter);
        logger.info("일기자동생성 시간이 되어 자동생성로직을 시작합니다. 현재 시간은 " + formattedTime + " 입니다.");

        // member autodiary시간이 auto_diary_time과 일치하는 멤버들 조회
        List<Member> members = memberRepository.findByAutoDiaryTimeHourAndMinute(now.getHour(), now.getMinute());

        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < members.size(); i++) {
            sb.append(members.get(i).getMemberId());
            if (i < members.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        // memberId 문자열을 로거로 출력
        logger.info(formattedTime + "시간에 일기를 자동생성할 memberId리스트입니다. " + sb.toString());

        for (Member member : members) {
            // auto_diary_time과 일치하는지 확인
            try {///try catch사용해서 중간에 일기만들기실패해도 다른유저 생성에 이상없도록.
                //현재는 유저 한명씩 제작하고있는데 쓰레드를 나눠서 작업을 시켜야할지.. 기능개선때 생각

                //멤버의 24시간기준 List<Long>cardIdList가져오기
                List<Long> cardIdList = findCardIdsWithin24Hours(member.getMemberId());

                //만약 24시간기준 찍은게 0개라면 일기 만들지않음
                if (cardIdList.isEmpty()) {
                    continue;
                }

                //장르 랜덤으로 1개 ~ 2개 결정하기 List<String> genreList
                Set<String> genreSet = new HashSet<>();
                Random random = new Random();
                EGenre[] genres = EGenre.values();
                int count = random.nextInt(2) + 1; // 1 또는 2
                while (genreSet.size() < count) {
                    int index = random.nextInt(genres.length);
                    genreSet.add(genres[index].name());
                }
                List<String> genreList = new ArrayList<>(genreSet);

//                logger.info(member.getMemberId() + "번 MemberId의 일기 자동생성을 시작하겠습니다.");

                DiaryResponseDto diary = createDiary(member.getMemberId(), cardIdList, genreList);
                //자동생성 알람로직 여기다가 작성예정 by 은녕
                String title = "그대만의 하루일기 도착";
                String body = "오늘의 가짜다이어리를 확인해보세요";
                alarmService.saveAlarm(new AlarmRequestDto(member.getMemberId(), diary.getDiaryId(), title, body, "AUTOMATIC"));
                alarmService.sendNotificationByToken(new AlarmResponseDto(member.getMemberId(), title, body));

                logger.info(member.getMemberId() + "번 MemberId의일기 자동 생성이 성공하였습니다.");
            } catch (Exception e) {
                logger.error(member.getMemberId() + " 번 MemberId의일기 자동 생성 과정중 에러 발생", e);
            }

        }
        logger.info(formattedTime + " 시간대의 카드 지동생성 로직을 종료합니다.");
    }

    //유저가 보유한 카드중 24시간 이내로 만들어진 카드들 반환 (5개넘을시 랜덤으로 5개고름)
    private List<Long> findCardIdsWithin24Hours(Long memberId) {
        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
        LocalDateTime yesterday = now.minusDays(1);
        List<Card> cards = cardRepository.findAllByMember_MemberIdAndCreatedAtBetween(memberId, yesterday, now);
        Collections.shuffle(cards);
        List<Long> cardIds = new ArrayList<>();
        for (int i = 0; i < Math.min(cards.size(), 5); i++) {
            cardIds.add(cards.get(i).getCardId());
        }
        cardIds.sort(Comparator.naturalOrder());//오름차순 정렬
        return cardIds;
    }
}