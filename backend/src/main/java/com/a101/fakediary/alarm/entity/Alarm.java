package com.a101.fakediary.alarm.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.enums.EAlarm;
import com.a101.fakediary.member.entity.Member;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Alarm extends BaseEntity {
    @SequenceGenerator(
            name = "ALARM_SEQ_GEN",
            sequenceName = "ALARM_SEQ",
            initialValue = 100,
            allocationSize = 1
    )
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ALARM_SEQ_GEN")
    private Long alarmId;

    @ManyToOne
    @JoinColumn(name = "member_id", nullable = false)
    private Member memberId;

    @Column(nullable = false)
    private Long requestId; // 교환 요청 관련 id

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String body;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private EAlarm alarmType; ////친구 일기교환, 친구 신청, 랜덤 일기교환, 자동생성일기, 수동생성일기

    @ColumnDefault("0") //0이 안 읽음, 1이 읽음
    @Column(nullable = false)
    private int status; // 읽었는지 여부 확인
}
