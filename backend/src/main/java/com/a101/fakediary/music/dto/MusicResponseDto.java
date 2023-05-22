package com.a101.fakediary.music.dto;

import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MusicResponseDto {
    private Long musicId;
    private String fileName;
    private String musicUrl;
}
