package com.a101.fakediary.gpt.api;

import com.a101.fakediary.gpt.request.ChatGPTRequest;
import com.a101.fakediary.gpt.response.ChatGPTResponse;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

@Component
@Slf4j
public class ChatGPTApi {
    private final String BASE_URL;
    private final String API_KEY;
    private final WebClient webClient;
    private final ObjectMapper OBJECT_MAPPER;

    public ChatGPTApi(@Value("${fake-diary.gpt.base-url}") String BASE_URL, @Value("${fake-diary.gpt.api-key}") String API_KEY) {
        this.BASE_URL = BASE_URL;
        this.API_KEY = API_KEY;
        this.OBJECT_MAPPER = new ObjectMapper();

        this.webClient = WebClient.builder()
                .baseUrl(this.BASE_URL)
                .clientConnector(new ReactorClientHttpConnector())
                .build();
    }

    public Mono<List<Map<String, String>>> makeDiaryContents(
            List<Map<String, String>> messages, String input) {

        String stop = null;
        if (!messages.isEmpty()) {
            Map<String, String> lastMessage = messages.get(messages.size() - 1);
            if (lastMessage.get("content").endsWith("}")) {
                stop = lastMessage.get("content");
            }
        }

        ChatGPTRequest requestBody = new ChatGPTRequest(
                "gpt-3.5-turbo",
                messages,
                500,
                1,
                stop,
                0.5
        );

//        return webClient.post()
//                .uri(BASE_URL)
//                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
//                .header(HttpHeaders.AUTHORIZATION, "Bearer " + API_KEY)
//                .body(BodyInserters.fromValue(requestBody))
//                .retrieve()
//                .bodyToMono(String.class)
//                .map(responseBody -> {
//                    ChatGPTResponse response = OBJECT_MAPPER.readValue(responseBody, ChatGPTResponse.class);
//                    String answer = response.getChoices().get(0).getMessage().getContent().trim();
//                    messages.add(Map.of("role", "assistant", "content", answer));
//                    if (!answer.endsWith("}")) {
//                        return makeDiaryContents(messages, "끊어진 부분부터 이어서 답변해줘. 비슷한 내용을 반복하지 말고 되도록 지정한 json 형식대로 답변을 빨리 마무리해줘.");
//                    }
//                    return messages;
//                });
        return null;
    }

}
