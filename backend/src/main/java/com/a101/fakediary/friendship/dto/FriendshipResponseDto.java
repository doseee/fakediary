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
    private short exchangeCnt;

    public FriendshipResponseDto(Long memberId, Long friendId, String nickname, short exchangeCnt) {
        this.memberId = memberId;
        this.friendId = friendId;
        this.nickname = nickname;
        this.exchangeCnt = exchangeCnt;
    }
}
