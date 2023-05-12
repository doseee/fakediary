package com.a101.fakediary.alarm.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AlarmRequestDto {
    private Long memberId;
    private Long requestId;
    private String title;
    private String body;
    private String alarmType;
}
