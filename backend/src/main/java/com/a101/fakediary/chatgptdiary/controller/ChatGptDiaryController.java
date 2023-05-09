package com.a101.fakediary.chatgptdiary.controller;

import com.a101.fakediary.chatgptdiary.api.ChatGptApi;
import com.a101.fakediary.chatgptdiary.dto.message.Message;
import com.a101.fakediary.chatgptdiary.dto.result.DiaryResultDto;
import com.a101.fakediary.chatgptdiary.prompt.ChatGptPrompts;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
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
            DiaryResultDto diaryResultDto = chatGptApi.askGpt35(characters, places, keywords);
//        log.info("content = " + responseDto.getChoices().get(0).getMessage().getContent());

            return new ResponseEntity<>(diaryResultDto, HttpStatus.OK);
        } catch(Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("에러 발생");
        }
    }

    @PostMapping("/chat-recursive")
    public ResponseEntity<?> askGptRecursive(@RequestBody Map<String, Object> requestBody) {
        List<String> characters = (List<String>)requestBody.get("characters");
        List<String> places = (List<String>)requestBody.get("places");
        List<String> keywords = (List<String>)requestBody.get("keywords");

        String prompt = ChatGptPrompts.generateUserPrompt(characters, places, keywords);
        List<Message> messages = new ArrayList<>();

        try {
            List<Message> messageList = chatGptApi.askGpt35(messages, prompt);
            StringBuilder diaryContent = new StringBuilder();

            log.info("messageList = " + messageList);

            for(Message message : messageList) {
                String role = message.getRole();
                String content = message.getContent();;

                if(role.equals("assistant")) {
                    diaryContent.append(content);
                }
            }
            log.info("diaryContent = " + diaryContent);
//        log.info("content = " + responseDto.getChoices().get(0).getMessage().getContent());
            ObjectMapper objectMapper = new ObjectMapper();
            DiaryResultDto diaryResultDto = objectMapper.readValue(diaryContent.toString(), DiaryResultDto.class);
            diaryResultDto.setPrompt(prompt);

            return new ResponseEntity<>(diaryResultDto, HttpStatus.OK);
        } catch(Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("에러 발생");
        }
    }
}
