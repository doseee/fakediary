package com.a101.fakediary.gpt.response;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatGPTResponse {
    private List<Choice> choices;

    @Getter
    @Setter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @ToString
    public static class Choice {
        private String message;
        private int index;
        private float logprobs;
        private float finishReason;
        private String[] prompts;
    }
}
