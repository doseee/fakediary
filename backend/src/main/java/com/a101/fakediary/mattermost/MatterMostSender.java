package com.a101.fakediary.mattermost;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Component
public class MatterMostSender {
    private final String MM_WEBHOOK_URL;
    private final String LOCATION;
    private final RestTemplate restTemplate;

    public MatterMostSender(@Value("${notification.mattermost.webhook-url}") String MM_WEBHOOK_URL,
                            @Value("${notification.mattermost.location}") String LOCATION) {
        this.restTemplate = new RestTemplate();
        this.MM_WEBHOOK_URL = MM_WEBHOOK_URL;
        this.LOCATION = LOCATION;
    }

    public void sendMessage(Exception e) {
        Map<String, Object> request = new HashMap<>();
        request.put("username", "허재성");
        request.put("text", "In " + LOCATION + ", " + e.getMessage());

        HttpEntity<Map<String, Object>> entity =  new HttpEntity<>(request);

        restTemplate.exchange(MM_WEBHOOK_URL, HttpMethod.POST, entity, String.class);
    }
}
