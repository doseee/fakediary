package com.a101.fakediary.randomexchangepool.dto.request;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RandomExchangePoolRegistDto {
    private Long diaryId;
    private Long ownerId;
}
