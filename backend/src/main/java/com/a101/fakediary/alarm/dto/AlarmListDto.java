package com.a101.fakediary.alarm.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
public class AlarmListDto {
    private Long alarmId;
    private Long requestId;
    private Long memberId;
    private String title;
    private String body;
    private String alarmType;
    private int status;

    public AlarmListDto(Long alarmId, Long requestId,Long memberId, String title, String body, String alarmType, int status) {
        this.alarmId = alarmId;
        this.requestId = requestId;
        this.memberId = memberId;
        this.title = title;
        this.body = body;
        this.alarmType = alarmType;
        this.status = status;
    }
}