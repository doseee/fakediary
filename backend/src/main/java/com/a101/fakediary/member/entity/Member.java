package com.a101.fakediary.member.entity;

import com.a101.fakediary.common.BaseEntity;
import lombok.*;

import javax.persistence.*;
import java.time.LocalTime;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Member extends BaseEntity {

    @SequenceGenerator(
            name = "MEMBER_SEQ_GEN",
            sequenceName = "MEMBER_SEQ",
            initialValue = 100,
            allocationSize = 1
    )
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MEMBER_SEQ_GEN")
    private Long memberId;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "nickname", nullable = false, length = 10)
    private String nickname;

    @Column(name = "diary_time", nullable = true)
    private LocalTime diaryTime;

    @Column(name = "diary_base_name", nullable = true)
    private String diaryBaseName;

    @Column(name = "firebase_uid", nullable = true)
    private String firebaseUid;

    @Column(name = "provider_id", nullable = true)
    private String providerId;

}
