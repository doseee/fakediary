package com.a101.fakediary.carddiarymapping.entity;

import com.a101.fakediary.common.BaseEntity;
import lombok.*;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "card_diary_mapping")
public class CardDiaryMapping extends BaseEntity {
    @EmbeddedId
    private CardDiaryMappingPK id;
    @Column(nullable = false)
    private int inputOrder;
}
