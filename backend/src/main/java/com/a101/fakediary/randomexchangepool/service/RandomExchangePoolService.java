package com.a101.fakediary.randomexchangepool.service;

import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.a101.fakediary.randomexchangepool.dto.request.RandomExchangePoolRegistDto;
import com.a101.fakediary.randomexchangepool.dto.response.RandomExchangePoolResponseDto;
import com.a101.fakediary.randomexchangepool.entity.RandomExchangePool;
import com.a101.fakediary.randomexchangepool.repository.RandomExchangePoolRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Random;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class RandomExchangePoolService {
    private final RandomExchangePoolRepository randomExchangePoolRepository;
    private final MemberRepository memberRepository;
    private final DiaryRepository diaryRepository;

    @Transactional
    public RandomExchangePoolResponseDto registRandomExchange(RandomExchangePoolRegistDto randomExchangePoolRegistDto) throws Exception {
        Long diaryId = randomExchangePoolRegistDto.getDiaryId();
        Long ownerId = randomExchangePoolRegistDto.getOwnerId();

        Diary diary = diaryRepository.findById(diaryId).orElseThrow(() -> new Exception("diary not found"));
        Member owner = memberRepository.findById(ownerId).orElseThrow(() -> new Exception("owner not found"));

        RandomExchangePool randomExchangePool = RandomExchangePool.builder()
                .diary(diary)
                .owner(owner)
                .randomDate(LocalDate.now())
                .build();

        randomExchangePoolRepository.save(randomExchangePool);

        return createRandomExchangePoolResponseDto(randomExchangePool);
    }

    private RandomExchangePoolResponseDto createRandomExchangePoolResponseDto(RandomExchangePool randomExchangePool) {
        Diary diary = randomExchangePool.getDiary();
        Member owner = randomExchangePool.getOwner();
        Diary exchangedDiary = randomExchangePool.getExchangedDiary();
        Member exchangedOwner = randomExchangePool.getExchangedOwner();

        return RandomExchangePoolResponseDto.builder()
                .randomExchangePoolId(randomExchangePool.getRandomExchangePoolId())
                .diaryId(diary.getDiaryId())
                .ownerId(owner.getMemberId())
                .randomDate(randomExchangePool.getRandomDate())
                .exchangedDiaryId(exchangedDiary != null ? exchangedDiary.getDiaryId() : null)
                .exchangedOwnerId(exchangedOwner != null ? exchangedOwner.getMemberId() : null)
                .build();
    }
}
