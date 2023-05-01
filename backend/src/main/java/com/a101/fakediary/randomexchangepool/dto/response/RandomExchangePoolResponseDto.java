package com.a101.fakediary.randomexchangepool.dto.response;

import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RandomExchangePoolResponseDto {
    private Long randomExchangePoolId;
    private Long diaryId;
    private Long ownerId;
    private LocalDate randomDate;
    private Long exchangedDiaryId;
    private Long exchangedOwnerId;
}
