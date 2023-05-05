package com.a101.fakediary.diary.dto;

import com.a101.fakediary.diary.entity.Diary;
import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaryRequestDto {
    //키워드, characters, places 없어도됨
    private Long memberId;
    private String characters;
    private String places;
    private String keyword;
    private String prompt;
    private String title;
    private String subtitles;
    private String detail;
    private String summary;
    private List<Long> cardIds;
    private List<String> genre;
    private List<String> diaryImageUrl;
}
