package com.a101.fakediary.card.controller;

import com.a101.fakediary.card.dto.response.CardResponseDto;
import com.a101.fakediary.card.service.CardService;
import lombok.RequiredArgsConstructor;
import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/card")
@RequiredArgsConstructor
public class CardController {
    private final CardService cardService;

    /**
     *
     *
     * @param origImageFile : FE에서 촬영한 원본 이미지
     * @param saveCardDtoString : FE에서 전송한 카드에 넣을 정보들
     * @return
     */
    @PostMapping
    public ResponseEntity<?> saveCard(
            @RequestPart(value = "origImageFile", required = true) MultipartFile origImageFile,
            @RequestParam(value = "saveCardDtoString")String saveCardDtoString
    ) {
        ResponseEntity<?> ret = null;

        try {
            MultipartFile cardImageFile = null; //  origImageFile을 이용해서 cardImageFile을 얻어야 함.
                                                //  DeepArtsEffect 호출해야 함.
            cardImageFile = cardService.getCardImageFile(origImageFile);

            Long cardId = cardService.saveCard(origImageFile, cardImageFile, saveCardDtoString);
            ret = new ResponseEntity<>("만들어진 카드 id = " + cardId, HttpStatus.OK);
        } catch(ParseException e) {
            e.printStackTrace();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    /**
     * 사용자가 가지고 있는 모든 카드들을 가져옴
     *
     * @param memberId
     * @return
     */
    @GetMapping("/{memberId}")
    public ResponseEntity<?>  listCards(@PathVariable(name = "memberId")Long memberId) {
      return new ResponseEntity<>(cardService.listCards(memberId), HttpStatus.OK);
    }

    /**
     * 사용자가 특정 카드를 뽑아서 상세 정보를 봄
     *
     * @param cardId
     * @return
     */
    @GetMapping("/pick/{cardId}")
    public ResponseEntity<?> findCard(@PathVariable(name = "cardId")Long cardId) {
        CardResponseDto cardResponseDto = null;

        try {
            cardResponseDto = cardService.findCard(cardId);
        } catch(Exception e) {
            e.printStackTrace();
        }

        return new ResponseEntity<>(cardResponseDto, HttpStatus.OK);
    }
}
