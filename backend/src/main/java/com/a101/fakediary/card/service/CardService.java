package com.a101.fakediary.card.service;

import com.a101.fakediary.card.dto.request.CardSaveRequestDto;
import com.a101.fakediary.card.dto.response.CardResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.imagefile.handler.ImageFileHandler;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserter;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import org.json.JSONObject;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class CardService {
    private final CardRepository cardRepository;
    private final MemberRepository memberRepository;
    private final ImageFileHandler s3ImageFileHandler;

    @Value("${fake-diary.deep-art.base-url}")
    private final String BASE_URL;

    @Value("${fake-diary.deep-art.api-key}")
    private final String API_KEY;

    @Value("${fake-diary.deep-art.access-key}")
    private final String ACCESS_KEY;

    @Value("${fake-diary.deep-art.secret-key}")
    private final String SECRET_KEY;

    @Transactional
    public Long saveCard(MultipartFile origImageFile, MultipartFile cardImageFile, String saveCardDtoString) throws Exception {
        Long ret = -1L;
        JSONParser jsonParser = new JSONParser(saveCardDtoString);
        Object obj = jsonParser.parse();
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.convertValue(obj, Map.class);
        CardSaveRequestDto saveCardDto = createSaveCardDto(map);
        Member member = memberRepository.findById(saveCardDto.getMemberId()).orElseThrow(() -> new Exception("member not found"));
        String origImageUrl = s3ImageFileHandler.uploadOnS3(origImageFile);
        String cardImageUrl = s3ImageFileHandler.uploadOnS3(cardImageFile);

        Card card = Card.builder()
                .member(member)
                .baseName(saveCardDto.getBaseName())
                .basePlace(saveCardDto.getBasePlace())
                .keyword(saveCardDto.getKeyword())
                .latitude(saveCardDto.getLatitude())
                .longitude(saveCardDto.getLongitude())
                .originCardImageName(origImageFile.getOriginalFilename())
                .origImageUrl(origImageUrl)
                .cardImageUrl(cardImageUrl)
                .build();

        cardRepository.save(card);

        return ret;
    }

    @Transactional
    public MultipartFile getCardImageFile(MultipartFile origImageFile) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.set("x-api-key", API_KEY);
        headers.set("x-api-access-key", ACCESS_KEY);
        headers.set("x-api-secret-key", SECRET_KEY);

        //  1. MultipartFile에서 이미지 데이터를 읽어온다.
        byte[] imageBytes = origImageFile.getBytes();

        //  2. api를 통해 style 목록을 얻어온다.
        WebClient client = WebClient.builder()
                .baseUrl(BASE_URL + "/styles")
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeaders(headers::addAll)
                .build();

        //  GET request를 보내 style의 목록을 얻어온다.
        Mono<String> response = client.get()
                .retrieve()
                .bodyToMono(String.class);

        response.subscribe(res -> {
            System.out.println("res = " + res);
        });

        //  3. api를 통해 이미지를 업로드한다.
        client = WebClient.builder()
                .baseUrl(BASE_URL + "/upload")
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.MULTIPART_FORM_DATA_VALUE)
                .defaultHeaders(headers::addAll)
                .build();

        //  이미지와 styleId를 reuqestMap에 넣어서 POST request를 보낸다.
        MultiValueMap<String, HttpEntity<?>> requestMap = new LinkedMultiValueMap<>();
        requestMap.add("styleId", new HttpEntity<>("c7984b32-1560-11e7-afe2-06d95fe194ed"));
        requestMap.add("image", new HttpEntity<>(imageBytes));

        response = client.post()
                .body(BodyInserters.fromMultipartData(requestMap))
                .retrieve()
                .bodyToMono(String.class);

        //  Mono의 subscribe 메서드를 사용해, response 값을 출력함.
        response.subscribe(res -> {
            System.out.println("res = " + res);
        });

        //  4. 처리 결과물을 받기 위해, 다시 새로운 WebClient를 생성
        client = WebClient.builder()
                .baseUrl(BASE_URL + "/result")
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeaders(headers::addAll)
                .build();

        //  submissionId를 정의한다.
        final String[] submissionId = {null};

        // Mono의 subscribe 메소드를 사용해, response 값에서 submissionId 값을 추출합니다.
        response.subscribe(res -> {
            JSONObject json = new JSONObject(res);
            submissionId[0] = json.getString("submissionId");
        });
        
        //  추출한 submissionIOd 값을 사용해 GET 요청을 보내고, 처리 결과물을 Mono로 받는다.
        response = client.get()
                .uri(uriBuilder -> uriBuilder.queryParam("submissionId", submissionId).build())
                .retrieve()
                .bodyToMono(String.class);
        
        //  Mono의 subscribe 메서드를 사용해 처리 결과물을 출력한다.
        response.subscribe(res -> {
            System.out.println("res = " + res); 
        });

        return null;
    }

    @Transactional(readOnly = true)
    public List<CardResponseDto> listCards(Long memberId){
        List<CardResponseDto> ret  = new ArrayList<>();

        try {
            List<Card> cardList = cardRepository.findAllByMemberId(memberId).orElseThrow(() -> new Exception());
            for (Card card : cardList) {
                ret.add(createCardResponseDto(card));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        return ret;
    }

    @Transactional(readOnly = true)
    public CardResponseDto findCard(Long cardId) throws Exception {
        CardResponseDto ret = null;

        Card card = cardRepository.findById(cardId).orElseThrow(() -> new Exception());
        ret = createCardResponseDto(card);

        return ret;
    }

    private CardSaveRequestDto createSaveCardDto(Map<String, Object> map) {
        return CardSaveRequestDto.builder()
                .memberId(Long.parseLong(String.valueOf(map.get("memberId"))))
                .baseName(String.valueOf(map.get("baseName")))
                .basePlace(String.valueOf(map.get("basePlace")))
                .keyword(String.valueOf(map.get("keyword")))
                .latitude(new BigDecimal(String.valueOf(map.get("latitude"))))
                .longitude(new BigDecimal(String.valueOf(map.get("longitude"))))
                .build();
    }

    private CardResponseDto createCardResponseDto(Card card) {
        CardResponseDto ret = CardResponseDto.builder()
                .cardId(card.getCardId())
                .memberId(card.getMember().getMemberId())
                .baseName(card.getBaseName())
                .basePlace(card.getBasePlace())
                .keywords(new ArrayList<>())
                .cardImageUrl(card.getCardImageUrl())
                .build();

        StringTokenizer tokens = new StringTokenizer(card.getKeyword(), "@");
        while(tokens.hasMoreTokens()) {
            ret.getKeywords().add(tokens.nextToken());
        }

        return ret;
    }
}
