package com.a101.fakediary.exchangediary.dto;

import com.a101.fakediary.enums.EExchangeType;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ExchangedRequestDiaryDto {
    private Long senderId;
    private Long sendDiaryId;
    private Long receiveOwnerId;
    private Long receiveDiaryId;
    private EExchangeType exchangeType;
}
