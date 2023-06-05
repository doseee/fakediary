package com.a101.fakediary.chatgptdiary.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

@Configuration
@Slf4j
public class ChatGptApiConfig {
    private static String OPEN_AI_API_KEY_35;
    private static String OPEN_AI_API_KEY_40;

    public ChatGptApiConfig(@Value("${fake-diary.chat-gpt.api-key-3-5}") String OPEN_AI_API_KEY_35, @Value("${fake-diary.chat-gpt.api-key-4-0}") String OPEN_AI_API_KEY_40) {
        ChatGptApiConfig.OPEN_AI_API_KEY_35 = OPEN_AI_API_KEY_35;
        ChatGptApiConfig.OPEN_AI_API_KEY_40 = OPEN_AI_API_KEY_40;
    }

    /**
     * RestTemplate 대신 WebClient로 변경해보기
     *
     * @return
     */
    public static RestTemplate chatGpt35RestTemplate() {
        RestTemplate restTemplate = new RestTemplate();

        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        restTemplate.getInterceptors().add((request, body, execution) -> {
            request.getHeaders().add("Authorization", "Bearer " + OPEN_AI_API_KEY_35);
            return execution.execute(request, body);
        });

        return restTemplate;
    }

    /**
     * RestTemplate 대신 WebClient로 변경해보기
     *
     * @return
     */
    public static RestTemplate chatGpt40RestTemplate() {
        RestTemplate restTemplate = new RestTemplate();

        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        restTemplate.getInterceptors().add((request, body, execution) -> {
            request.getHeaders().add("Authorization", "Bearer " + OPEN_AI_API_KEY_40);
            return execution.execute(request, body);
        });

        return restTemplate;
    }
}
