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
    private Long memberId;
    private String keyword;
    private String prompt;
    private String title;
    private String detail;
    private String summary;
    private List<Long> cardIds;
    private List<String> genre;
    private List<String> diaryImageUrl;
}
