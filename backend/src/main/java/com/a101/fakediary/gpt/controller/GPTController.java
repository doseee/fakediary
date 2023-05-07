package com.a101.fakediary.gpt.controller;

import com.a101.fakediary.gpt.dto.request.QuestionRequestDto;
import com.a101.fakediary.gpt.dto.response.GPTResponseDto;
import com.a101.fakediary.gpt.service.GPTService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/chat-gpt")
public class GPTController {
    private final GPTService gptService;

    @PostMapping
    public GPTResponseDto sendQuestion(@RequestBody QuestionRequestDto requestDto) {
        return gptService.askQuestion(requestDto);
    }

}
