package com.a101.fakediary.exchangediary.service;

import com.a101.fakediary.card.dto.response.CardSaveResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.enums.EExchangeType;
import com.a101.fakediary.exchangediary.dto.ExchangedRequestDiaryDto;
import com.a101.fakediary.exchangediary.dto.request.ExchangedDiarySaveRequestDto;
import com.a101.fakediary.exchangediary.dto.response.ExchangedDiaryResponseDto;
import com.a101.fakediary.exchangediary.entity.ExchangedDiary;
import com.a101.fakediary.exchangediary.repository.ExchangedDiaryRepository;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.StringTokenizer;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class ExchangedDiaryService {
    private final ExchangedDiaryRepository exchangedDiaryRepository;
    private final MemberRepository memberRepository;
    private final DiaryRepository diaryRepository;

    @Transactional
    public ExchangedDiaryResponseDto saveExchangeDiary(ExchangedDiarySaveRequestDto exchangedDiarySaveRequestDto) throws Exception {
        Member sender = memberRepository.findById(exchangedDiarySaveRequestDto.getSenderId())
                .orElseThrow(() -> new Exception("sender doesn't exist"));
        Diary sendDiary = diaryRepository.findById(exchangedDiarySaveRequestDto.getSendDiaryId())
                .orElseThrow(() -> new Exception("send diary doesn't exist"));
        Member receiver = memberRepository.findById(exchangedDiarySaveRequestDto.getReceiverId())
                .orElseThrow(() -> new Exception("receiver doesn't exist"));
        Diary receiveDiary = diaryRepository.findById(exchangedDiarySaveRequestDto.getReceiveDiaryId())
                .orElseThrow(() -> new Exception("receive diary doesn't exist"));
        EExchangeType exchangeType = exchangedDiarySaveRequestDto.getFriendExchangeType();

        ExchangedDiary exchangedDiary = ExchangedDiary.builder()
                .sender(sender)
                .senderDiary(sendDiary)
                .receiver(receiver)
                .receiverDiary(receiveDiary)
                .exchangeType(exchangeType)
                .build();

        exchangedDiaryRepository.save(exchangedDiary);
        return createExchangedDiaryResponseDto(exchangedDiary);
    }

    private ExchangedDiaryResponseDto createExchangedDiaryResponseDto(ExchangedDiary exchangedDiary) {
        return ExchangedDiaryResponseDto.builder()
                .exchangedDiaryId(exchangedDiary.getExchangedDiaryId())
                .senderId(exchangedDiary.getSender().getMemberId())
                .sendDiaryId(exchangedDiary.getSenderDiary().getDiaryId())
                .receiverId(exchangedDiary.getReceiver().getMemberId())
                .receiveDiaryId(exchangedDiary.getReceiverDiary().getDiaryId())
                .friendExchangeType(exchangedDiary.getExchangeType())
                .build();
    }

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
