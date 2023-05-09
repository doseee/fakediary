package com.a101.fakediary.friendexchangerequest.service;

import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.diary.service.DiaryService;
import com.a101.fakediary.enums.EExchangeType;
import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.exchangediary.dto.ExchangedRequestDiaryDto;
import com.a101.fakediary.exchangediary.service.ExchangedDiaryService;
import com.a101.fakediary.friendexchangerequest.dto.FriendExchangeManageDto;
import com.a101.fakediary.friendexchangerequest.dto.FriendExchangeRequestDto;
import com.a101.fakediary.friendexchangerequest.entity.FriendExchangeRequest;
import com.a101.fakediary.friendexchangerequest.repository.FriendExchangeRequestRepository;
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
    private final DiaryService diaryService;

    @Transactional
    public void requestFriendExchange(FriendExchangeRequestDto request) throws Exception{
        friendExchangeRequestRepository.save(requestEntity(request));
    }

    @Transactional
    public void manageFriendExchange(FriendExchangeManageDto manage) throws Exception{
        //수락했으므로 상태 변경 및 일기 저장
        FriendExchangeRequest friend = friendExchangeRequestRepository.findByfriendExchangeRequestId(manage.getFriendExchangeRequestId());
        friend.setReceiverDiary(diaryService.findNotDeletedDiaryById(manage.getReceiverDiaryId()));
        friend.setStatus(manage.getStatus());

        //동시에 교환된 일기에도 저장
        ExchangedRequestDiaryDto exchange = new ExchangedRequestDiaryDto(friend.getSender().getMemberId(), friend.getSenderDiary().getDiaryId(), friend.getReceiver().getMemberId(), friend.getReceiverDiary().getDiaryId(), EExchangeType.valueOf("F"));
        exchangedDiaryService.saveExchangeDiary(exchange);
    }

    private FriendExchangeRequest requestEntity(FriendExchangeRequestDto request) throws Exception{
        return FriendExchangeRequest.builder()
                .sender(memberRepository.findByMemberId(request.getSenderId()))
                .senderDiary(diaryService.findNotDeletedDiaryById(request.getSenderDiaryId()))
                .receiver(memberRepository.findByMemberId(request.getReceiverId()))
                .status(ERequestStatus.valueOf("WAITING"))
                .build();
    }
}
