package com.a101.fakediary.randomexchangepool.dto.request;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RandomExchangePoolUpdateDto {
    private Long randomExchangePoolId;  //  업데이트할 랜덤 교환 id
    private Long exchangedDiaryId;  //  교환된 일기 id
    private Long exchangedOwnerId;  //  교환된 일기 주인 id
}
