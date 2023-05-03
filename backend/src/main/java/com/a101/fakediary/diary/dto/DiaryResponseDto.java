package com.a101.fakediary.diary.dto;

import com.a101.fakediary.diary.entity.Diary;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaryResponseDto {
    private Long diaryId;
    private Long memberId;
    private String characters;
    private String places;
    private String keyword;
    private String prompt;
    private String title;
    private String subtitles;
    private String detail;
    private String summary;
    private boolean isExchanged;

    public DiaryResponseDto(Diary entity) {
        this.diaryId = entity.getDiaryId();
        this.memberId = entity.getDiaryId();
        this.characters = entity.getCharacters();
        this.places = entity.getPlaces();
        this.keyword = entity.getKeyword();
        this.prompt = entity.getPrompt();
        this.title = entity.getTitle();
        this.subtitles = entity.getSubtitles();
        this.detail = entity.getDetail();
        this.summary = entity.getSummary();
        this.isExchanged = entity.isExchanged();
    }
}
