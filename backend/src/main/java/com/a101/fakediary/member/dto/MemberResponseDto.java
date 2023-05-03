package com.a101.fakediary.member.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberResponseDto {

    private Long memberId;

    private String email;

    private String nickname;

    private LocalTime autoDiaryTime;

    private String diaryBaseName;

    private String firebaseUid;

    private String providerId;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

}
