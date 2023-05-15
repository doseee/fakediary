package com.a101.fakediary.chatgptdiary.dto.result;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TitleSubtitlesResultDto {
    private String title;
    private List<String> subtitles;
}
