package com.a101.fakediary.gpt3.dto.response;

import com.a101.fakediary.gpt3.dto.Choice;
import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class GPT3ResponseDto {
    private String id;
    private String object;
    private LocalDate created;
    private String model;
    private List<Choice> choices;
}
