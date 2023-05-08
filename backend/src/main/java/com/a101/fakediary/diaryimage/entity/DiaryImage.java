package com.a101.fakediary.diaryimage.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.diary.entity.Diary;
import lombok.*;

import javax.persistence.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class DiaryImage extends BaseEntity {
    @SequenceGenerator(
            name = "DIARY_IMAGE_SEQ_GEN",
            sequenceName = "DIARY_IMAGE_SEQ",
            initialValue = 100,
            allocationSize = 1
    )


    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DIARY_IMAGE_SEQ_GEN")
    @Id
    private Long diaryImageId;

    @ManyToOne
    @JoinColumn(name = "diary_id")
    private Diary diary;

    @Column(nullable = false)
    private String diaryImageUrl;

    @Column(nullable = false)
    private String ImagePrompt;
}
