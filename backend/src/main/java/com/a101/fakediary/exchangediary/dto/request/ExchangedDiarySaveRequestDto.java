package com.a101.fakediary.exchangediary.dto.request;

import com.a101.fakediary.enums.EExchangeType;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ExchangedDiarySaveRequestDto {
    private Long senderId;
    private Long sendDiaryId;
    private Long receiverId;
    private Long receiveDiaryId;
    private EExchangeType friendExchangeType;
}
