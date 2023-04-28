package com.a101.fakediary.card.service;

import com.a101.fakediary.card.dto.request.CardSaveRequestDto;
import com.a101.fakediary.card.dto.response.CardResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.deeparteffects.api.DeepArtEffectsApi;
import com.a101.fakediary.deeparteffects.styles.DeepArtEffectsStyles;
import com.a101.fakediary.imagefile.handler.ImageFileHandler;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.json.JSONParser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import reactor.core.publisher.Mono;

import java.math.BigDecimal;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class CardService {
    private final CardRepository cardRepository;
    private final MemberRepository memberRepository;
    private final ImageFileHandler s3ImageFileHandler;
    private final DeepArtEffectsApi deepArtEffectsApi;

    @Transactional
    public Long saveCard(MultipartFile origImageFile, String cardImageFileUrl, int styleIndex, String styleId, String saveCardDtoString) throws Exception {
        Long ret = -1L;
        JSONParser jsonParser = new JSONParser(saveCardDtoString);
        Object obj = jsonParser.parse();
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.convertValue(obj, Map.class);
        CardSaveRequestDto saveCardDto = createCardSaveRequestDto(map);
        MultipartFile cardImageFile = ImageFileHandler.downloadImage(cardImageFileUrl);

        log.info("cardImageFile = " + cardImageFile);

        List<Member> memberList = memberRepository.findAll();
        log.info("memberList = " + memberList);

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
                .cardStyleIndex(styleIndex)
                .cardStyleId(styleId)
                .build();

        ret = cardRepository.save(card).getCardId();

        return ret;
    }

    @Transactional
    public Map<String, String> getCardImageInfo(MultipartFile origImageFile) throws Exception {
        Map<String, String> ret = new HashMap<>();

        int randomStyleIdx = DeepArtEffectsStyles.getRandomStyleIdx();
        String styleId = DeepArtEffectsStyles.getStyleId(randomStyleIdx);   //  적용된 styleId
        String submissionId = deepArtEffectsApi.uploadImageWithStyleId(origImageFile, styleId);

        log.info("submissionId = " + submissionId);

        String cardImageFileUrl = deepArtEffectsApi.getCardImageUrl(submissionId);  //  카드 이미지 URL

        ret.put("styleIndex", String.valueOf(randomStyleIdx));
        ret.put("styleId", styleId);
        ret.put("cardImageFileUrl", cardImageFileUrl);

        return ret;
    }

    @Transactional(readOnly = true)
    public Mono<String> getDeepArtEffectsStyles() {
        return deepArtEffectsApi.getDeepArtEffectsStyles();
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

    private CardSaveRequestDto createCardSaveRequestDto(Map<String, Object> map) {
        Object baseNameObj = map.get("baseName");
        Object basePlaceObj = map.get("basePlace");
        Object latitudeObj = map.get("latitude");
        Object longitudeObj = map.get("longitude"); //  nullable한 속성들

        log.info("memberId = " + map.get("memberId"));
        log.info("baseName = " + baseNameObj);
        log.info("basePlace = " + basePlaceObj);
        log.info("keyword = " + map.get("keyword"));
        log.info("latitude = " + latitudeObj);
        log.info("longitude = " + longitudeObj);

        Long memberId = Long.parseLong(String.valueOf(map.get("memberId")));
        String baseName = baseNameObj != null ? String.valueOf(baseNameObj) : null;
        String basePlace = basePlaceObj != null ? String.valueOf(basePlaceObj) : null;
        String keyword = String.valueOf(map.get("keyword"));
        BigDecimal latitude = latitudeObj != null ? new BigDecimal(String.valueOf(latitudeObj)) : null;
        BigDecimal longitude = longitudeObj != null ? new BigDecimal(String.valueOf(latitudeObj)) : null;

        return CardSaveRequestDto.builder()
                .memberId(memberId)
                .baseName(baseName)
                .basePlace(basePlace)
                .keyword(keyword)
                .latitude(latitude)
                .longitude(longitude)
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
