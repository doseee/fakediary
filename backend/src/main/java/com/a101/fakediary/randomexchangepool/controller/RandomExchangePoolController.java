package com.a101.fakediary.randomexchangepool.controller;

import com.a101.fakediary.randomexchangepool.dto.request.RandomExchangePoolRegistDto;
import com.a101.fakediary.randomexchangepool.service.RandomExchangePoolService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/random-exchange")
@RequiredArgsConstructor
public class RandomExchangePoolController {
    private final RandomExchangePoolService randomExchangePoolService;
    /**
     * randomExchangePoolRegistDto에 저장된 정보
     * @param randomExchangePoolRegistDto
     * @return
     */
    @PostMapping
    public ResponseEntity<?> registerRandomExchange(@RequestBody RandomExchangePoolRegistDto randomExchangePoolRegistDto) {
        return null;
    }
}
