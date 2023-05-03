package com.a101.fakediary.diary.dto;

import com.a101.fakediary.diary.entity.Diary;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaryRequestDto {
    private Long memberId;
    private String characters;
    private String places;
    private String keyword;
    private String prompt;
    private String title;
    private String subtitles;
    private String detail;
    private String summary;
    private String[] genre;
}
