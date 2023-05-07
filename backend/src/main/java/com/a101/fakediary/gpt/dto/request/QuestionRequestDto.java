package com.a101.fakediary.gpt.dto.request;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class QuestionRequestDto {
    private String question;
}
