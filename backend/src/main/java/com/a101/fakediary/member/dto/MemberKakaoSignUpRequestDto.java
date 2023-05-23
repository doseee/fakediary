package com.a101.fakediary.member.dto;

import com.a101.fakediary.member.entity.Member;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberKakaoSignUpRequestDto {

    private Long kakaoUid;

    private String firebaseUid;

    public Member toEntity() {
        return Member.builder()
                .kakaoUid(kakaoUid)
                .firebaseUid(firebaseUid)
                .build();
    }
}
