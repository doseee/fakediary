package com.a101.fakediary.friendrequest.dto;

import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.friendrequest.entity.FriendRequest;
import com.a101.fakediary.member.entity.Member;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FriendManageDto {
    private Long friendRequestId;
    private ERequestStatus status;
}
