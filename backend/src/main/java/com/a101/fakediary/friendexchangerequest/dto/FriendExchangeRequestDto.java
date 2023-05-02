package com.a101.fakediary.friendexchangerequest.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FriendExchangeRequestDto {
    private Long senderId;
    private Long senderDiaryId;
    private Long receiverId;
}
