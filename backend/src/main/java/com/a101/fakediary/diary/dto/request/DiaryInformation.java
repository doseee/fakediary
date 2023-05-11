package com.a101.fakediary.diary.dto.request;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DiaryInformation {
    private Long memberId;
    private List<Long> cardIdList;
    private List<String> genreList;
}
