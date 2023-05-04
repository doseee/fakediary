package com.a101.fakediary.card.controller;

import com.a101.fakediary.card.dto.response.CardMadeDiaryResponseDto;
import com.a101.fakediary.card.dto.response.CardSaveResponseDto;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.card.service.CardService;
import com.a101.fakediary.diary.service.DiaryService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/card")
@RequiredArgsConstructor
public class CardController {
    private final CardService cardService;
    private final DiaryService diaryService;
    private final CardRepository cardRepository;

    /**
     *
     *
     * @param origImageFile : FE에서 촬영한 원본 이미지
     * @param cardSaveRequestDtoString : FE에서 전송한 카드에 넣을 정보들
     * @return
     */
    @ApiOperation(value = "카드 생성 요청", notes = "body를 form-data 형태로 origImageFile과 cardSaveRequestDtoString을 묶어서 함께 전송")
    @PostMapping
    public ResponseEntity<?> saveCard(
            @RequestPart(value = "origImageFile", required = true) MultipartFile origImageFile,
            @RequestParam(value = "cardSaveRequestDtoString")String cardSaveRequestDtoString
    ) {
        log.info("saveCard!!!!");
        ResponseEntity<?> ret = null;

        try {
            Map<String, String> map = cardService.getCardImageInfo(origImageFile);   //  origImageFile을 이용해서 cardImageFile을 얻어야 함.

            int styleIndex = Integer.parseInt(map.get("styleIndex"));
            String styleId = map.get("styleId");                        //  적용된 DeepArtEffects style id
            String cardImageFileUrl = map.get("cardImageFileUrl");      //  DeepArtEffects style 적용된 카드 이미지 URL

            log.info("cardImageFileUrl = " + cardImageFileUrl);

            CardSaveResponseDto cardSaveResponseDto = cardService.saveCard(origImageFile, cardImageFileUrl, styleIndex, styleId, cardSaveRequestDtoString);
            ret = new ResponseEntity<>(cardSaveResponseDto, HttpStatus.OK);
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
    @ApiOperation(value = "카드 조회 요청", notes = "memberId에 해당하는 회원이 보유한 카드 전체 리스트를 반환함")
    @GetMapping("/{memberId}")
    public ResponseEntity<?>  listCards(@PathVariable(name = "memberId")Long memberId) {
        log.info("listCards!!!!");
        List<CardSaveResponseDto> ret = null;
        try {
            ret = cardService.listCards(memberId);
        } catch(Exception e) {
            e.printStackTrace();
        }
      return new ResponseEntity<>(ret, HttpStatus.OK);
    }

    /**
     * 사용자가 특정 카드를 뽑아서 상세 정보를 봄
     *
     * @param cardId
     * @return
     */
    @GetMapping("/pick/{cardId}")
    public ResponseEntity<?> findCard(@PathVariable(name = "cardId")Long cardId) {
        log.info("findCard!!!!");
        CardSaveResponseDto cardResponseDto = null;

        try {
            cardResponseDto = cardService.findCard(cardId);
        } catch(Exception e) {
            e.printStackTrace();
        }

        return new ResponseEntity<>(cardResponseDto == null ? "해당 카드가 없음" : cardResponseDto, HttpStatus.OK);
    }

    /**
     * 카드 스타일 가져오기
     *
     * @return
     */
    @GetMapping("/styles")
    public ResponseEntity<?> findCardStyles() {
        log.info("findCardStyles!!!");
        return new ResponseEntity<>(cardService.getDeepArtEffectsStyles().block(), HttpStatus.OK);
    }

    /**
     * 개발용
     * cardId라는 카드를 제거함
     *
     * @param cardId
     * @return
     */
    @DeleteMapping("/{cardId}")
    public ResponseEntity<?> deleteCardByCardId(@PathVariable("cardId") Long cardId) {
        long ret = -1;

        try {
            ret = cardService.deleteCardByCardId(cardId);
        } catch(Exception e) {
            e.printStackTrace();;
        }

        return new ResponseEntity<>("삭제된 카드 번호 = " + ret, HttpStatus.OK);
    }
    @ApiOperation(value = "특정 카드로 만들어진 일기 리스트 조회")
    @GetMapping("/diary/{cardId}")
    public ResponseEntity<?> findDiaryListByCardId(@PathVariable("cardId") Long cardId) {
        if(cardRepository.findById(cardId).isEmpty()){
            return ResponseEntity.badRequest().body("존재하지 않는 카드 아이디입니다.");
        }

        try {
            //카드&일기 매핑 테이블에서 해당 카드id와 함께 복합키를 이루고 있는 diaryId리스트를 가져와서
            List<Long> diaryIdsByCardId = cardService.getDiaryIdsByCardId(cardId);

            //해당 diaryId로 responseDto List를 반환해줌(id, 제목, 요약, 썸네일)
            List<CardMadeDiaryResponseDto> cardMadeDiaryResponseDtos = diaryService.findDiaryListFromCardList(diaryIdsByCardId);

            //이과정에서 이미지 표지를 가져오기위해 diaryId와 일치하는 diaryImageId리스트틀 가져온 이후 가장낮은 id의 diaryImageUrl을 반환하면 표지
            return ResponseEntity.ok().body(cardMadeDiaryResponseDtos);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
}
