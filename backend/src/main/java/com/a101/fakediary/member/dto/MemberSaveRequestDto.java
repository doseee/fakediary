package com.a101.fakediary.member.dto;

import com.a101.fakediary.member.entity.Member;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberSaveRequestDto {
    private String email;

    private String password;

    private String nickname;

    private String firebaseUid;

    public Member toEntity() {
        return Member.builder()
                .email(email)
                .password(password)
                .nickname(nickname)
                .firebaseUid(firebaseUid)
                .build();
    }
}
