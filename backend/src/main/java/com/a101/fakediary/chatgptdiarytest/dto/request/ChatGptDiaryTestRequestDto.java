package com.a101.fakediary.chatgptdiarytest.dto.request;

import com.a101.fakediary.chatgptdiarytest.dto.message.Message;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatGptDiaryTestRequestDto {
    private String model;
    private List<Message> messages;
    private int n;
    @JsonProperty("max_tokens")
    private Integer maxTokens;
    private double temperature;
}
