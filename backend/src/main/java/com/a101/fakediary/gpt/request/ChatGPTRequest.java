package com.a101.fakediary.gpt.request;

import lombok.*;

import java.util.List;
import java.util.Map;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatGPTRequest {
    private String model;
    private List<Map<String, String>> messages;
    private int maxTokens;
    private int n;
    private String stop;
    private double temperature;
}
