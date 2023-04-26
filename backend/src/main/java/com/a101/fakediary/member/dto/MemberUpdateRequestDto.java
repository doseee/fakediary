package com.a101.fakediary.member.dto;

import lombok.*;

import java.time.LocalTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberUpdateRequestDto {

    private String nickname;

    private LocalTime autoDiaryTime;

    private String diaryBaseName;

}
