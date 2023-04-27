package com.a101.fakediary.card.controller;

import com.a101.fakediary.card.dto.response.CardResponseDto;
import com.a101.fakediary.card.service.CardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RestController
@RequestMapping("/card")
@RequiredArgsConstructor
public class CardController {
    private final CardService cardService;

    /**
     *
     *
     * @param origImageFile : FE에서 촬영한 원본 이미지
     * @param cardSaveRequestDtoString : FE에서 전송한 카드에 넣을 정보들
     * @return
     */
    @PostMapping
    public ResponseEntity<?> saveCard(
            @RequestPart(value = "origImageFile", required = true) MultipartFile origImageFile,
            @RequestParam(value = "cardSaveRequestDtoString")String cardSaveRequestDtoString
    ) {
        ResponseEntity<?> ret = null;

        try {
            String cardImageFileUrl = cardService.getCardImageFileUrl("c7984b32-1560-11e7-afe2-06d95fe194ed", origImageFile);; //  origImageFile을 이용해서 cardImageFile을 얻어야 함.
                                                //  DeepArtsEffect 호출해야 함.

            log.info("cardIamgeFileUrl = " + cardImageFileUrl);

            Long cardId = cardService.saveCard(origImageFile, cardImageFileUrl, cardSaveRequestDtoString);
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

    /**
     *
     * @return
     */
    @GetMapping("/styles")
    public ResponseEntity<?> findCardStyles() {
        return new ResponseEntity<>(cardService.getDeepArtEffectsStyles().block(), HttpStatus.OK);
    }
}
