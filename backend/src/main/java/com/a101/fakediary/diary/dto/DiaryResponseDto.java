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
        String keyword = entity.getKeyword();
        if (keyword != null) {
            StringTokenizer st = new StringTokenizer(keyword, "@");
            String[] keywordArr = new String[st.countTokens()];

            while (st.hasMoreTokens())
                keywordArr[i++] = st.nextToken();
            this.keyword = keywordArr;
        }

        String characters = entity.getCharacters();
        if (characters != null) {
            i = 0;
            StringTokenizer st = new StringTokenizer(characters, "@");
            String[] characterArr = new String[st.countTokens()];

            while (st.hasMoreTokens())
                characterArr[i++] = st.nextToken();
            this.characters = characterArr;
        }

        String places = entity.getPlaces();
        if (places != null) {
            i = 0;
            StringTokenizer st = new StringTokenizer(places, "@");
            String[] placeArr = new String[st.countTokens()];

            while (st.hasMoreTokens())
                placeArr[i++] = st.nextToken();
            this.places = placeArr;
        }

        this.prompt = entity.getPrompt();
        this.title = entity.getTitle();

        String subtitle = entity.getSubtitles();
        if (subtitle != null) {
            i = 0;
            StringTokenizer st = new StringTokenizer(subtitle, "@");
            String[] subtitleArr = new String[st.countTokens()];

            while (st.hasMoreTokens())
                subtitleArr[i++] = st.nextToken();
            this.subtitles = subtitleArr;
        }

        this.detail = entity.getDetail();
        this.summary = entity.getSummary();
        this.isExchanged = entity.isExchanged();
    }
}
