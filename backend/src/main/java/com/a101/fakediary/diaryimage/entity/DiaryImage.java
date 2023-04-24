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
    @Id
    private Long diaryImageId;

    @ManyToOne
    @JoinColumn(name = "diary_id")
    private Diary diary;

    @Column(nullable = false)
    private String diaryImageUrl;
}
