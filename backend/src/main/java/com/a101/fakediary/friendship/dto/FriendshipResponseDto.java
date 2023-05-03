package com.a101.fakediary.friendship.dto;

import com.a101.fakediary.friendship.entity.Friendship;
import lombok.*;

@Getter
@Setter
@Builder
public class FriendshipResponseDto {
    private Long memberId;
    private Long friendId;
    private String nickname; //friend의 닉네임

    public FriendshipResponseDto(Long memberId, Long friendId, String nickname) {
        this.memberId = memberId;
        this.friendId = friendId;
        this.nickname = nickname;
    }
}
