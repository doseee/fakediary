package com.a101.fakediary.carddiarymapping.entity;

import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.diary.entity.Diary;

import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Embeddable
public class CardDiaryMappingPK implements Serializable {
    @ManyToOne
    @JoinColumn(name="card_id")
    private Card card;
    @ManyToOne
    @JoinColumn(name="diary_id")
    private Diary diary;
}
