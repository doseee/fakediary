package com.a101.fakediary.chatgptdiary.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

@Configuration
@Slf4j
public class OpenAIRestTemplateConfig {
    private static String openAiApiKey;

    public OpenAIRestTemplateConfig(@Value("${fake-diary.chat-gpt.api-key}") String openAiApiKey) {
        OpenAIRestTemplateConfig.openAiApiKey = openAiApiKey;
    }
//    @Bean
//    @Qualifier("openaiRestTemplate")
    public static RestTemplate openAiRestTemplate() {
        RestTemplate restTemplate = new RestTemplate();

        log.info("openAiApiKey = " + openAiApiKey);

        restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
        restTemplate.getInterceptors().add((request, body, execution) -> {
            request.getHeaders().add("Authorization", "Bearer " + openAiApiKey);
            return execution.execute(request, body);
        });

        return restTemplate;
    }
}
