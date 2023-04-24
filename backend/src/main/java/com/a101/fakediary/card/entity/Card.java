package com.a101.fakediary.card.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.member.entity.Member;
import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;


@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Card extends BaseEntity {

    @SequenceGenerator(
            name = "CARD_SEQ_GEN",
            sequenceName = "CARD_SEQ",
            initialValue = 100,
            allocationSize = 1
    )
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CARD_SEQ_GEN")
    private Long cardId;

    @ManyToOne
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;


    @Column(name = "keyword", length = 30, nullable = false)
    private String keyword;

    @Column(name = "langitude", nullable = true)
    private BigDecimal langitude;

    @Column(name = "longitude", nullable = true)
    private BigDecimal longitude;

    @Column(name = "origin_card_image_url", nullable = false)
    private String originCardImageUrl;

    @Column(name = "card_image_url", nullable = false)
    private String cardImageUrl;
}
