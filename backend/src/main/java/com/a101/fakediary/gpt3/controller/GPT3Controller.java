package com.a101.fakediary.gpt3.controller;

import com.a101.fakediary.gpt3.dto.request.QuestionRequestDto;
import com.a101.fakediary.gpt3.dto.response.GPT3ResponseDto;
import com.a101.fakediary.gpt3.service.GPT3Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/gpt-3")
public class GPT3Controller {
    private final GPT3Service gpt3Service;

    @PostMapping
    public GPT3ResponseDto sendQuestion(@RequestBody QuestionRequestDto requestDto) {
        return gpt3Service.askQuestion(requestDto);
    }

}
