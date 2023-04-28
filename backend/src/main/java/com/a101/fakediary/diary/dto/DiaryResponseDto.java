package com.a101.fakediary.diary.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaryResponseDto {
    private Long diaryId;
    private Long memberId;
    private String keyword;
    private String prompt;
    private String title;
    private String detail;
    private String summary;
    private boolean isExchanged;
}
