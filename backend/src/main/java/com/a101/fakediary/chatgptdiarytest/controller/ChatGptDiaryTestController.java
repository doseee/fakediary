package com.a101.fakediary.chatgptdiarytest.controller;

import com.a101.fakediary.chatgptdiarytest.dto.message.Message;
import com.a101.fakediary.chatgptdiarytest.dto.request.ChatGptDiaryTestRequestDto;
import com.a101.fakediary.chatgptdiarytest.dto.response.ChatGptDiaryTestResponseDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;

@RestController
@RequestMapping("/chat-gpt-diary-test")
@Slf4j
public class ChatGptDiaryTestController {
    @Qualifier("openaiRestTemplate")
    @Autowired
    private RestTemplate restTemplate;

    @Value("${fake-diary.gpt.model}")
    private String model;

    @Value("${fake-diary.gpt.chat-gpt-base-url}")
    private String apiUrl;

    @GetMapping("/chat")
    public String chat(@RequestParam String prompt) {
        //  create request
        ChatGptDiaryTestRequestDto requestDto = ChatGptDiaryTestRequestDto.builder()
                .model(model)
                .n(1)
                .temperature(0.5)
                .messages(new ArrayList<>())
                .build();

        requestDto.getMessages().add(new Message("user", prompt));

        log.info("apiUrl = " + apiUrl);
        log.info("requestDto = " + requestDto);

        //  call the API
        ChatGptDiaryTestResponseDto responseDto = restTemplate.postForObject(apiUrl, requestDto, ChatGptDiaryTestResponseDto.class);

        if(responseDto == null || responseDto.getChoices() == null || responseDto.getChoices().isEmpty())
            return "No response";

        return responseDto.getChoices().get(0).getMessage().getContent();
    }
}
