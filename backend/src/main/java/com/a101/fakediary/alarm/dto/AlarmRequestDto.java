package com.a101.fakediary.alarm.dto;

import com.a101.fakediary.enums.EAlarm;
import com.a101.fakediary.member.entity.Member;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

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
