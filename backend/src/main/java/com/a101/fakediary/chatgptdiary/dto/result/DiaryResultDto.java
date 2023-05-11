package com.a101.fakediary.chatgptdiary.dto.result;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DiaryResultDto {
    private String title;
    private String summary;
    private List<String> subtitles;
    private List<String> contents;
    private String prompt;
}
