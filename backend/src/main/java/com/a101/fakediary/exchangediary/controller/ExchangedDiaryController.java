package com.a101.fakediary.exchangediary.controller;

import com.a101.fakediary.exchangediary.dto.ExchangedRequestDiaryDto;
import com.a101.fakediary.exchangediary.service.ExchangedDiaryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Api(value = "ExchangedDiaryController")
@RequestMapping("/exchangediary")
@RequiredArgsConstructor
public class ExchangedDiaryController {

    private final ExchangedDiaryService exchangedDiaryService;

    @ApiOperation(value = "교환된 일기 저장")
    @PostMapping("/save")
    public ResponseEntity<?> saveExchangeDiary(@RequestBody ExchangedRequestDiaryDto exchange) {
        try {
            exchangedDiaryService.saveExchangeDiray(exchange);
            return new ResponseEntity(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
