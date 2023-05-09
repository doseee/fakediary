package com.a101.fakediary.friendrequest.service;

import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.friendrequest.dto.FriendManageDto;
import com.a101.fakediary.friendrequest.dto.FriendRequestDto;
import com.a101.fakediary.friendrequest.entity.FriendRequest;
import com.a101.fakediary.friendrequest.repository.FriendRequestRepository;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class FriendRequestService {

    private final FriendRequestRepository friendRequestRepository;
    private final MemberRepository memberRepository;

    @Transactional
    public void requestFriend(FriendRequestDto request) {
        FriendRequest friend = friendRequestRepository.checkDuplicate(request.getSenderId(), request.getReceiverId());
        if (friend == null)
            friendRequestRepository.save(requestEntity(request));
        else
            throw new IllegalArgumentException("이미 친구 추가 요청을 했습니다.");
    }

    @Transactional
    public void manageFriend(FriendManageDto manage) {
        FriendRequest friend = friendRequestRepository.findByFriendRequestId(manage.getFriendRequestId());
        friend.setStatus(manage.getStatus());
    }

    private FriendRequest requestEntity(FriendRequestDto request) {
        return FriendRequest.builder()
                .senderId(memberRepository.findByMemberId(request.getSenderId()))
                .receiverId(memberRepository.findByMemberId(request.getReceiverId()))
                .status(ERequestStatus.valueOf("WAITING"))
                .build();
    }
}
