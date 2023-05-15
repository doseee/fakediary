package com.a101.fakediary.diary.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaryItemsDto {
    private List<String> characters;
    private List<String> places;
    private List<String> keywords;
    private List<String> genres;
}
