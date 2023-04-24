package com.a101.fakediary.card.dto.request;

import com.a101.fakediary.member.entity.Member;
import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CardRequestDto {
    private Long memberId;                  //  카드 만들 사람의 pk
    private String keyword;                 //
    private BigDecimal langitude;
    private BigDecimal longitude;
    private String originCardImageUrl;
    private String cardImageUrl;

}
