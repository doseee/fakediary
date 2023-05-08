package com.a101.fakediary.chatgptdiarytest.dto.response;

import com.a101.fakediary.chatgptdiarytest.dto.message.Message;
import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatGptDiaryTestResponseDto {
//    private String id;
//    private String object;
//    private LocalDate created;
//    private String model;
    private List<Choice> choices;

    @Getter
    @Setter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @ToString
    public static class Choice {
        private int index;
        private Message message;

    }
}
