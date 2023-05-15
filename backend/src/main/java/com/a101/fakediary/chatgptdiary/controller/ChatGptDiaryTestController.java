package com.a101.fakediary.chatgptdiary.controller;

import com.a101.fakediary.chatgptdiary.api.ChatGptApi;
import com.a101.fakediary.chatgptdiary.dto.message.Message;
import com.a101.fakediary.papago.api.PapagoApi;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/chat-gpt-diary")
public class ChatGptDiaryTestController {
    private final ChatGptApi chatGptApi;
    private final PapagoApi papagoApi;

    @PostMapping("/loading")
    public ResponseEntity<?> getLoadingMessages(@RequestBody String genre) {
        log.info("getLoadingMessages");
        log.info("genre = " + genre);

        try {
            List<Message> messages = chatGptApi.chatGpt35LoadingMessage(genre);
            String shortStory = messages.get(2).getContent();

            shortStory = papagoApi.translateEngToKor(shortStory);

            return new ResponseEntity<>(shortStory, HttpStatus.OK);
        } catch(Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
