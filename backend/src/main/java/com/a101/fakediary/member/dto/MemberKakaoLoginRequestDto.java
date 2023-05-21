package com.a101.fakediary.member.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberKakaoLoginRequestDto {
    private String kakaoUid;
}
