package com.a101.fakediary.card.controller;

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

    @PostMapping
    public ResponseEntity<?> saveCard(
            @RequestPart(value = "origImageFile", required = true) MultipartFile origImageFile,
            @RequestParam(value = "saveCardDtoString")String saveCardDtoString
    ) {
        ResponseEntity<?> ret = null;

        try {
            MultipartFile cardImageFile = null; //  origImageFile을 이용해서 cardImageFile을 얻어야 함.
                                                //  DeepArtsEffect 호출해야 함.


            Long cardId = cardService.saveCard(origImageFile, cardImageFile, saveCardDtoString);
            ret = new ResponseEntity<>("만들어진 카드 id = " + cardId, HttpStatus.OK);
        } catch(ParseException e) {
            e.printStackTrace();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return ret;
    }
}
