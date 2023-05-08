package com.a101.fakediary.chatgptdiarytest.dto.request;

import com.a101.fakediary.chatgptdiarytest.dto.message.Message;
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
    private double temperature;
}
