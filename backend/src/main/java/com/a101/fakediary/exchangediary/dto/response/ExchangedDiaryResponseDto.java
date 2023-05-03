package com.a101.fakediary.exchangediary.dto.response;

import com.a101.fakediary.enums.EExchangeType;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ExchangedDiaryResponseDto {
    private Long exchangedDiaryId;
    private Long senderId;
    private Long sendDiaryId;
    private Long receiverId;
    private Long receiveDiaryId;
    private EExchangeType friendExchangeType;
}
