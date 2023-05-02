package com.a101.fakediary.exchangediary.dto;

import com.a101.fakediary.enums.EExchangeType;
import com.a101.fakediary.exchangediary.entity.ExchangedDiary;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ExchangedResponseDiaryDto { //교환된 일기 주기
    private Long id;
    private Long senderId;
    private Long sendDiaryId;
    private Long receiveOwnerId;
    private Long receiveDiaryId;
    private EExchangeType exchangeType;

    public ExchangedResponseDiaryDto(ExchangedDiary entity) {
        this.id = entity.getExchangedDiaryId();
        this.senderId = entity.getSender().getMemberId();
        this.sendDiaryId = entity.getSenderDiary().getDiaryId();
        this.receiveOwnerId = entity.getReceiver().getMemberId();
        this.receiveDiaryId = entity.getReceiverDiary().getDiaryId();
        this.exchangeType = entity.getExchangeType();
    }
}
