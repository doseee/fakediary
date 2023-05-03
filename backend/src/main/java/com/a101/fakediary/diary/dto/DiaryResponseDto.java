package com.a101.fakediary.diary.dto;

import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.enums.EGenre;
import lombok.*;

import java.util.StringTokenizer;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaryResponseDto {
    private Long diaryId;
    private Long memberId;
    private String[] keyword;
    private String prompt;
    private String title;
    private String detail;
    private String summary;
    private boolean isExchanged;
    private EGenre genre;

    public DiaryResponseDto(Diary entity) {
        this.diaryId = entity.getDiaryId();
        this.memberId = entity.getMember().getMemberId();

        StringTokenizer st = new StringTokenizer(entity.getKeyword(), "@");
        String[] s = new String[st.countTokens()];
        int i = 0;

        while(st.hasMoreTokens())
            s[i++] = st.nextToken();
        this.keyword = s;

        this.prompt = entity.getPrompt();
        this.title = entity.getTitle();
        this.detail = entity.getDetail();
        this.summary = entity.getSummary();
        this.isExchanged = entity.isExchanged();
    }
}
