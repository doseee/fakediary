package com.a101.fakediary.card.entity;

//import com.a101.fakediary.common.BaseEntity;
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

    @Column
    private String basePlace;   //  장소 이름

    @Column(name = "keyword", length = 30, nullable = false)
    private String keyword;

    @Column(name = "latitude", nullable = true)
    private BigDecimal latitude;

    @Column(name = "longitude", nullable = true)
    private BigDecimal longitude;

    @Column(name = "origin_card_image_name", nullable = false)
    private String originCardImageName;

    @Column(name = "origin_card_image_url", nullable = false)
    private String origImageUrl;

    @Column(name = "card_image_url", nullable = false)
    private String cardImageUrl;
}
