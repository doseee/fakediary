package com.a101.fakediary.member.entity;

import com.a101.fakediary.common.BaseEntity;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

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
    @Column(name = "member_id")
    private Long memberId;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "nickname", nullable = false, length = 10, unique = true)
    private String nickname;

    @Column(name = "auto_diary_time", nullable = true)
    private LocalTime autoDiaryTime;

    @Column(name = "diary_base_name", nullable = true)
    private String diaryBaseName;

    @Column(name = "firebase_uid", nullable = true, unique = true)
    private String firebaseUid;

    @Column(name = "provider_id", nullable = true)
    private String providerId;

    @Column(name = "is_random_exchanged")
    @ColumnDefault("false")
    @Builder.Default()
    private boolean isRandomExchanged = false;

}
