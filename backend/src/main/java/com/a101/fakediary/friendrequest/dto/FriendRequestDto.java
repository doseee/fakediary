package com.a101.fakediary.friendrequest.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FriendRequestDto {
    private Long senderId;
    private Long receiverId;
}
