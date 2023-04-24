package com.a101.fakediary.friendship.entity;

import lombok.EqualsAndHashCode;

import java.io.Serializable;

@EqualsAndHashCode
public class FriendshipId implements Serializable {
    private Long memberId;
    private Long friendId;

}