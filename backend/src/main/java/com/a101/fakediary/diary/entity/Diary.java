package com.a101.fakediary.diary.entity;

import com.a101.fakediary.common.BaseEntity;
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
public class Diary extends BaseEntity {
    @SequenceGenerator(
            name="DIARY_SEQ_GEN",
            sequenceName = "DIARY_SEQ",
            initialValue = 100,
            allocationSize = 1
    )
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DIARY_SEQ_GEN")
    private Long diaryId;
    @ManyToOne
    @JoinColumn(name="member_id", nullable = false)
    private Member member;
    @Column(nullable = false, length = 500)
    private String keyword;
    @Column(nullable = false, length = 2000)
    private String prompt;
    @Column(nullable = false, length = 400)
    private String title;
    @Lob
    @Column(nullable = false, length = 32000)
    private String detail;
    @Column(nullable = false, length = 1000)
    private String summary;
    @Column(nullable = false)
    @ColumnDefault("false")
    private boolean isExchanged;
}
