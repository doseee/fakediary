package com.a101.fakediary.music.dto;

import com.a101.fakediary.music.entity.Music;
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
    private String mood;

    public MusicResponseDto(Music music) {
        this.musicId = music.getMusicId();
        this.fileName = music.getFileName();
        this.musicUrl = music.getMusicUrl();
        this.mood = music.getMood();
    }
}
