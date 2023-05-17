package com.a101.fakediary.soundraw.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SoundRawRequestDto {
    private List<String> genreList;
    private Long diaryPk;
}
