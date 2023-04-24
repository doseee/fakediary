package com.a101.fakediary.card.service;

import com.a101.fakediary.card.dto.request.SaveCardDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.imagefile.handler.S3ImageFileHandler;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.Map;

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
        SaveCardDto saveCardDto = createSaveCardDto(map);
        Member member = memberRepository.findById(saveCardDto.getMemberId()).orElseThrow(() -> new Exception("member not found"));
        String origImageUrl = s3ImageFileHandler.uploadOnS3(origImageFile);
        String cardImageUrl = s3ImageFileHandler.uploadOnS3(cardImageFile);

        Card card = Card.builder()
                .member(member)
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

    private SaveCardDto createSaveCardDto(Map<String, Object> map) {
        return SaveCardDto.builder()
                .memberId(Long.parseLong(String.valueOf(map.get("memberId"))))
                .keyword(String.valueOf(map.get("keyword")))
                .latitude(new BigDecimal(String.valueOf(map.get("latitude"))))
                .longitude(new BigDecimal(String.valueOf(map.get("longitude"))))
                .build();
    }
}
