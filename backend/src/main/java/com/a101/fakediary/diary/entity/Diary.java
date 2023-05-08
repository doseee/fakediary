package com.a101.fakediary.diary.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.member.entity.Member;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Diary extends BaseEntity {
    @SequenceGenerator(
            name="DIARY_SEQ_GEN",
            sequenceName = "DIARY_SEQ",
            initialValue = 1000,
            allocationSize = 1
    )
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DIARY_SEQ_GEN")
    @Column(name = "diary_id")
    private Long diaryId;
    @ManyToOne
    @JoinColumn(name="member_id", nullable = false)
    private Member member;
    @Column(length = 500)
    private String characters;
    @Column(length = 500)
    private String places;
    @Column(length = 500)
    private String keyword;
    @Column(nullable = false, length = 2000)
    private String prompt;
    @Column(nullable = false, length = 400)
    @Size(max = 10, message = "Title은 띄어쓰기 포함 10글자 이내여야합니다.")
    private String title;
    @Column(length = 400)
    private String subtitles;
    @Column(nullable = false, columnDefinition = "TEXT")
    private String detail;
    @Column(nullable = false, length = 1000)
    private String summary;
    @Column(nullable = false)
    @ColumnDefault("false")
    private boolean isExchanged;
}
