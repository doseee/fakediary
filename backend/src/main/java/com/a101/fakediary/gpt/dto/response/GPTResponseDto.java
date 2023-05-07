package com.a101.fakediary.gpt.dto.response;

import com.a101.fakediary.gpt.dto.Choice;
import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class GPTResponseDto {
    private String id;
    private String object;
    private LocalDate created;
    private String model;
    private List<Choice> choices;
}
