package com.a101.fakediary.card.service;

import com.a101.fakediary.card.dto.request.CardSaveRequestDto;
import com.a101.fakediary.card.dto.response.CardResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.imagefile.handler.S3ImageFileHandler;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.json.JSONParser;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
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
    private final S3ImageFileHandler s3ImageFileHandler;

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

    public CardResponseDto findCard(Long cardId) {
        CardResponseDto ret = null;

        try {
            Card card = cardRepository.findById(cardId).orElseThrow(() -> new Exception());
            ret = createCardResponseDto(card);
        } catch(Exception e) {
            e.printStackTrace();
        }

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
