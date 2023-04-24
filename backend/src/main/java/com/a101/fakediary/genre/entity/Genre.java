package com.a101.fakediary.genre.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.diary.entity.GenrePK;
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
   @EmbeddedId
   private GenrePK id;
}
