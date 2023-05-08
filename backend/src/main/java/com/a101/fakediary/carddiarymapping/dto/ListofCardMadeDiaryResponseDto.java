package com.a101.fakediary.carddiarymapping.dto;

import com.a101.fakediary.card.entity.Card;
import lombok.*;

import java.math.BigDecimal;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ListofCardMadeDiaryResponseDto {
    private Long cardId;
    private String baseName;
    private String basePlace;
    private String keyword;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private String originCardImageName;
    private String origImageUrl;
    private String cardImageUrl;
    private Integer cardStyleIndex;
    private String cardStyleId;

    public ListofCardMadeDiaryResponseDto(Card card) {
        this.cardId = card.getCardId();
        this.baseName = card.getBaseName();
        this.basePlace = card.getBasePlace();
        this.keyword = card.getKeyword();
        this.latitude = card.getLatitude();
        this.longitude = card.getLongitude();
        this.originCardImageName = card.getOriginCardImageName();
        this.origImageUrl = card.getOrigImageUrl();
        this.cardImageUrl = card.getCardImageUrl();
        this.cardStyleIndex = card.getCardStyleIndex();
        this.cardStyleId = card.getCardStyleId();
    }
}