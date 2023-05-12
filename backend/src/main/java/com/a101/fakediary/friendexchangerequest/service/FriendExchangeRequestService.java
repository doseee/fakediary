package com.a101.fakediary.friendexchangerequest.service;

import com.a101.fakediary.alarm.dto.AlarmRequestDto;
import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.alarm.entity.Alarm;
import com.a101.fakediary.alarm.repository.AlarmRepository;
import com.a101.fakediary.alarm.service.AlarmService;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.enums.EExchangeType;
import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.exchangediary.dto.ExchangedRequestDiaryDto;
import com.a101.fakediary.exchangediary.service.ExchangedDiaryService;
import com.a101.fakediary.friendexchangerequest.dto.FriendExchangeManageDto;
import com.a101.fakediary.friendexchangerequest.dto.FriendExchangeRequestDto;
import com.a101.fakediary.friendexchangerequest.entity.FriendExchangeRequest;
import com.a101.fakediary.friendexchangerequest.repository.FriendExchangeRequestRepository;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
@RequiredArgsConstructor
public class FriendExchangeRequestService {
    private final FriendExchangeRequestRepository friendExchangeRequestRepository;
    private final MemberRepository memberRepository;
    private final DiaryRepository diaryRepository;
    private final ExchangedDiaryService exchangedDiaryService;
    private final AlarmService alarmService;
    private final AlarmRepository alarmRepository;

    @Transactional
    public void requestFriendExchange(FriendExchangeRequestDto request) {
        //친구 일기 교환 신청 저장
        FriendExchangeRequest exchange = friendExchangeRequestRepository.save(requestEntity(request));

        //친구 일기 교환 알림 저장, 푸시알림 발신
        Member member = memberRepository.findByMemberId(request.getSenderId());
        String title = member.getNickname() + "님이 교환할 일기를 가져왔어요";
        String body = "교환할 일기는 뭐가 좋을까~";
        alarmService.saveAlarm(new AlarmRequestDto(request.getReceiverId(), exchange.getFriendExchangeRequestId(), title, body, "FRIEND"));
        alarmService.sendNotificationByToken(new AlarmResponseDto(request.getReceiverId(),  title, body));
    }

    @Transactional
    public void manageFriendExchange(FriendExchangeManageDto manage) throws Exception {
        //수락했으므로 상태 변경 및 일기 저장
        FriendExchangeRequest friend = friendExchangeRequestRepository.findByfriendExchangeRequestId(manage.getFriendExchangeRequestId());
        friend.setReceiverDiary(diaryRepository.findByDiaryId(manage.getReceiverDiaryId()));
        friend.setStatus(ERequestStatus.ACCEPTED);

        //동시에 교환된 일기에도 저장
        ExchangedRequestDiaryDto exchange = new ExchangedRequestDiaryDto(friend.getSender().getMemberId(), friend.getSenderDiary().getDiaryId(), friend.getReceiver().getMemberId(), friend.getReceiverDiary().getDiaryId(), EExchangeType.valueOf("F"));
        exchangedDiaryService.saveExchangeDiary(exchange);

        //동시에 알림 읽음처리
        Alarm alarm = alarmRepository.findFriend(friend.getFriendExchangeRequestId());
        alarm.setStatus(1);
    }

    private FriendExchangeRequest requestEntity(FriendExchangeRequestDto request) {
        return FriendExchangeRequest.builder()
                .sender(memberRepository.findByMemberId(request.getSenderId()))
                .senderDiary(diaryRepository.findByDiaryId(request.getSenderDiaryId()))
                .receiver(memberRepository.findByMemberId(request.getReceiverId()))
                .status(ERequestStatus.valueOf("WAITING"))
                .build();
    }
}
