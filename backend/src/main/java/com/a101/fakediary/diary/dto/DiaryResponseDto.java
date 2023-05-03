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
    private String[] characters;
    private String[] places;
    private String[] keyword;
    private String prompt;
    private String title;
    private String[] subtitles;
    private String detail;
    private String summary;
    private boolean isExchanged;
    private EGenre genre;

    public DiaryResponseDto(Diary entity) {
        int i = 0;

        this.diaryId = entity.getDiaryId();
        this.memberId = entity.getMember().getMemberId();
        StringTokenizer st = new StringTokenizer(entity.getKeyword(), "@");
        String[] keywordArr = new String[st.countTokens()];

        while(st.hasMoreTokens())
            keywordArr[i++] = st.nextToken();
        this.keyword = keywordArr;

        i = 0;
        st = new StringTokenizer(entity.getCharacters(), "@");
        String[] characterArr = new String[st.countTokens()];

        while(st.hasMoreTokens())
            characterArr[i++] = st.nextToken();
        this.characters =  characterArr;

        i = 0;
        st = new StringTokenizer(entity.getPlaces(), "@");
        String[] placeArr = new String[st.countTokens()];

        while(st.hasMoreTokens())
            placeArr[i++] = st.nextToken();
        this.places =  characterArr;

        this.prompt = entity.getPrompt();
        this.title = entity.getTitle();

        i = 0;
        st = new StringTokenizer(entity.getSubtitles(), "@");
        String[] subtitleArr = new String[st.countTokens()];

        while(st.hasMoreTokens())
            subtitleArr[i++] = st.nextToken();
        this.subtitles =  characterArr;

        this.detail = entity.getDetail();
        this.summary = entity.getSummary();
        this.isExchanged = entity.isExchanged();
    }
}
