package com.a101.fakediary.chatgptdiary.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

@Configuration
@Slf4j
public class OpenAIRestTemplateConfig {
    private static String OPEN_AI_API_KEY_35;
    private static String OPEN_AI_API_KEY_40;

    public OpenAIRestTemplateConfig(@Value("${fake-diary.chat-gpt.api-key-3-5}") String OPEN_AI_API_KEY_35, @Value("${fake-diary.chat-gpt.api-key-4-0}") String OPEN_AI_API_KEY_40) {
        OpenAIRestTemplateConfig.OPEN_AI_API_KEY_35 = OPEN_AI_API_KEY_35;
        OpenAIRestTemplateConfig.OPEN_AI_API_KEY_40 = OPEN_AI_API_KEY_40;
    }

    //    public OpenAIRestTemplateConfig(@Value("${fake-diary.chat-gpt.api-key-3-5}") String openAiApiKey1) {
//        openAiApiKey = openAiApiKey1;
//    }
//    @Bean
//    @Qualifier("openaiRestTemplate")
    public static RestTemplate openAiRestTemplate35() {
        RestTemplate restTemplate = new RestTemplate();

        log.info("OPEN_AI_API_KEY_35 = " + OPEN_AI_API_KEY_35);
        log.info("OPEN_AI_API_KEY_40 = " + OPEN_AI_API_KEY_40);

        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        restTemplate.getInterceptors().add((request, body, execution) -> {
            request.getHeaders().add("Authorization", "Bearer " + OPEN_AI_API_KEY_35);
            return execution.execute(request, body);
        });

        return restTemplate;
    }

    public static RestTemplate openAiRestTemplate40() {
        RestTemplate restTemplate = new RestTemplate();

        log.info("OPEN_AI_API_KEY_35 = " + OPEN_AI_API_KEY_35);
        log.info("OPEN_AI_API_KEY_40 = " + OPEN_AI_API_KEY_40);

        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        restTemplate.getInterceptors().add((request, body, execution) -> {
            request.getHeaders().add("Authorization", "Bearer " + OPEN_AI_API_KEY_40);
            return execution.execute(request, body);
        });

        return restTemplate;
    }
}
