package com.a101.fakediary.alarm.dto;

import lombok.*;

import java.util.Map;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AlarmResponseDto {
    private Long memberId;
    private String title;
    private String body;
    private Map<String, String> data;

    public AlarmResponseDto(Long memberId, String title, String body) {
        this.memberId = memberId;
        this.title = title;
        this.body = body;
    }
}