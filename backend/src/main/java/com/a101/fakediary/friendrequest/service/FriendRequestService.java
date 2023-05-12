package com.a101.fakediary.friendrequest.service;

import com.a101.fakediary.alarm.dto.AlarmRequestDto;
import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.alarm.entity.Alarm;
import com.a101.fakediary.alarm.repository.AlarmRepository;
import com.a101.fakediary.alarm.service.AlarmService;
import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.friendrequest.dto.FriendRequestDto;
import com.a101.fakediary.friendrequest.entity.FriendRequest;
import com.a101.fakediary.friendrequest.repository.FriendRequestRepository;
import com.a101.fakediary.friendship.dto.FriendshipDto;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class FriendRequestService {

    private final FriendRequestRepository friendRequestRepository;
    private final MemberRepository memberRepository;
    private final AlarmRepository alarmRepository;
    private final AlarmService alarmService;

    @Transactional
    public void requestFriend(FriendRequestDto request) {
        FriendRequest friend = friendRequestRepository.checkDuplicate(request.getSenderId(), request.getReceiverId());
        if (friend == null) {
            //친구 요청 저장
            FriendRequest friendRequest = friendRequestRepository.save(requestEntity(request));

            //친구 요청 알림 저장, 푸시 알림 발신
            Member member = memberRepository.findByMemberId(request.getSenderId());
            String title = member.getNickname() + "님이 친구가 되고싶어 해요";
            String body = "친구 맺고 일기를 교환해볼까요?";
            alarmService.saveAlarm(new AlarmRequestDto(request.getReceiverId(), friendRequest.getFriendRequestId(), title, body, "REQUEST"));
            alarmService.sendNotificationByToken(new AlarmResponseDto(request.getReceiverId(), title, body));
        }
        else
            throw new IllegalArgumentException("이미 친구 추가 요청을 했습니다.");
    }

    @Transactional
    public void manageFriend(FriendshipDto dto) {
        FriendRequest friend = friendRequestRepository.checkDuplicate(dto.getMemberId(), dto.getFriendId());
        friend.setStatus(ERequestStatus.ACCEPTED);

        //동시에 알림 읽음처리
        Alarm alarm = alarmRepository.findRequest(friend.getFriendRequestId());
        alarm.setStatus(1);
    }

    private FriendRequest requestEntity(FriendRequestDto request) {
        return FriendRequest.builder()
                .senderId(memberRepository.findByMemberId(request.getSenderId()))
                .receiverId(memberRepository.findByMemberId(request.getReceiverId()))
                .status(ERequestStatus.valueOf("WAITING"))
                .build();
    }
}
