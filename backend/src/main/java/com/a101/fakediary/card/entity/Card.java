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

    @Column(length = 10)
    private String baseName;    //  주인공 이름

    @Column(length = 20)
    private String basePlace;   //  장소 이름

    @Column(name = "keyword", length = 40)  //  Card 키워드 현재는 "A@B@C"로 @로 구분하고 있음.
    private String keyword;

    @Transient
    private String improvedKeyword; //  JSON 형태의 문자열로 받기

    @Column(name = "latitude", nullable = true, precision = 20, scale = 10)
    private BigDecimal latitude;

    @Column(name = "longitude", nullable = true, precision = 20, scale = 10)
    private BigDecimal longitude;

    @Column(name = "origin_card_image_name", nullable = false)
    private String originCardImageName;

    @Column(name = "origin_card_image_url", nullable = false)
    private String origImageUrl;

    @Column(name = "card_image_url", nullable = false)
    private String cardImageUrl;

    @Column(name = "card_style_index", nullable = false)
    private Integer cardStyleIndex;

    @Column(name = "card_style_id", nullable = false)
    private String cardStyleId;
}
