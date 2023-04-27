package com.a101.fakediary.card.service;

import com.a101.fakediary.card.dto.request.CardSaveRequestDto;
import com.a101.fakediary.card.dto.response.CardResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.deeparteffects.api.DeepArtEffectsApi;
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
    public Long saveCard(MultipartFile origImageFile, String cardImageFileUrl, String saveCardDtoString) throws Exception {
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
//        String cardImageUrl = "123456";

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

        ret = cardRepository.save(card).getCardId();

        return ret;
    }

    @Transactional
    public String getCardImageFileUrl(String styleId, MultipartFile origImageFile) throws Exception {
        String submissionId = deepArtEffectsApi.uploadImageWithStyleId(origImageFile, styleId);

        log.info("submissionId = " + submissionId);

        return deepArtEffectsApi.getCardImageUrl(submissionId);
//        return null;
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
