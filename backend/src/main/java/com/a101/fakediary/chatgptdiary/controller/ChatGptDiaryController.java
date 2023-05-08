package com.a101.fakediary.chatgptdiary.controller;

import com.a101.fakediary.chatgptdiary.api.ChatGptApi;
import com.a101.fakediary.chatgptdiary.dto.result.DiaryResultDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/chat-gpt-diary")
@RequiredArgsConstructor
@Slf4j
public class ChatGptDiaryController {
    private final ChatGptApi chatGptApi;

    @PostMapping("/chat")
    public ResponseEntity<?> askGpt(@RequestBody Map<String, Object> requestBody) {
        List<String> characters = (List<String>)requestBody.get("characters");
        List<String> places = (List<String>)requestBody.get("places");
        List<String> keywords = (List<String>)requestBody.get("keywords");

        try {
            DiaryResultDto diaryResultDto = chatGptApi.askGpt(characters, places, keywords);
//        log.info("content = " + responseDto.getChoices().get(0).getMessage().getContent());

            return new ResponseEntity<>(diaryResultDto, HttpStatus.OK);
        } catch(Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("에러 발생");
        }
    }
}
