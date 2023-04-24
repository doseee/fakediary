package com.a101.fakediary.card.dto.request;

import lombok.*;

import java.math.BigDecimal;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SaveCardDto {
    private Long memberId;                  //  카드 만들 사람의 pk
    private String keyword;                 //  키워드(최대 3개) 모음
    private BigDecimal latitude;            //  사진 찍은 위치(위도)
    private BigDecimal longitude;           //  사진 찍은 위치(경도)
}
