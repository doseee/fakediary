package com.a101.fakediary.friendship.dto;

import com.a101.fakediary.friendship.entity.Friendship;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FriendshipDto {
    private Long memberId;
    private Long friendId;

    public Friendship toEntity() {
        return Friendship.builder()
                .memberId(memberId)
                .friendId(friendId)
                .build();
    }

}
