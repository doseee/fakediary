package com.a101.fakediary.genre.entity;

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
@Table(name = "genre")
public class Genre extends BaseEntity {
   @Id
   @Column(name = "genre_id")
   private Long genreId;

   @Column(length = 30, nullable = false)
   private String genre;

   @ManyToOne
   @JoinColumn(name = "diary_id")
   private Diary diary;
}
