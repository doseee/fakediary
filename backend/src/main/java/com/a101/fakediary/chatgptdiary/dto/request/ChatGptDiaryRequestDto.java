package com.a101.fakediary.chatgptdiary.dto.request;

import com.a101.fakediary.chatgptdiary.dto.message.Message;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatGptDiaryRequestDto {
    private String model;
    private List<Message> messages;
    private int n;
    private String stop;
    @JsonProperty("max_tokens")
    private Integer maxTokens;
    private double temperature;
}
