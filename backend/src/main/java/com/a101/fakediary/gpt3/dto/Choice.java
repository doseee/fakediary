package com.a101.fakediary.gpt3.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Choice implements Serializable {
    private String text;
    private Integer index;
    @JsonProperty("finish_reason")
    private String finishReason;

}
