package com.a101.fakediary.member.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberLoginRequestDto {
    private String email;
    private String password;
    private String firebaseUid;
}
