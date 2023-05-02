package com.a101.fakediary.exchangediary.service;

import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.exchangediary.dto.ExchangedRequestDiaryDto;
import com.a101.fakediary.exchangediary.entity.ExchangedDiary;
import com.a101.fakediary.exchangediary.repository.ExchangedDiaryRepository;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class ExchangedDiaryService {

    private final ExchangedDiaryRepository exchangedDiaryRepository;
    private final MemberRepository memberRepository;
    private final DiaryRepository diaryRepository;

    public ExchangedDiary requestEntity(ExchangedRequestDiaryDto request) {
        return ExchangedDiary.builder()
                .sender(memberRepository.findByMemberId(request.getSenderId()))
                .senderDiary(diaryRepository.findByDiaryId(request.getSendDiaryId()))
                .receiver(memberRepository.findByMemberId(request.getReceiveOwnerId()))
                .receiverDiary(diaryRepository.findByDiaryId(request.getReceiveDiaryId()))
                .exchangeType(request.getExchangeType())
                .build();
    }

    public void saveExchangeDiray(ExchangedRequestDiaryDto request) {
        exchangedDiaryRepository.save(requestEntity(request));
    }
}
