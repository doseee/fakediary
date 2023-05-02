package com.a101.fakediary.friendexchangerequest.dto;

import com.a101.fakediary.enums.ERequestStatus;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FriendExchangeManageDto {
    private Long friendExchangeRequestId;
    private Long receiverDiaryId;
    private ERequestStatus status;
}