package com.a101.fakediary.diary.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class DiaryFilterDto {
    private Long id;
    private Long memberId;
    private String genre;
}
