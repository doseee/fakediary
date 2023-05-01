package com.a101.fakediary.genre.entity;

import com.a101.fakediary.diary.entity.Diary;
import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

@Getter
@Setter
@Embeddable
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class GenrePK implements Serializable {
    @ManyToOne
    @JoinColumn(name="diary_id", nullable = false)
    private Diary diary;
    @Column(nullable = false, length = 30)
    private String genre;
}
