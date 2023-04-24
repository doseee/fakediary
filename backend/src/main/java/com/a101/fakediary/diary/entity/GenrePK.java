package com.a101.fakediary.diary.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.io.Serializable;
import java.util.List;

@Getter
@Setter
@Embeddable
public class GenrePK implements Serializable {
    @OneToMany
    private List<Diary> diary;
    @Column(nullable = false, length = 30)
    private String genre;
}
