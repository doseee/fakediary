package com.a101.fakediary.genre.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GenreDto {
    private Long diaryId;
    private String genre;
}
