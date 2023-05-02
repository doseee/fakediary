package com.a101.fakediary.randomexchangepool.service;

import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.a101.fakediary.randomexchangepool.dto.request.RandomExchangePoolRegistDto;
import com.a101.fakediary.randomexchangepool.dto.request.RandomExchangePoolUpdateDto;
import com.a101.fakediary.randomexchangepool.dto.response.RandomExchangePoolResponseDto;
import com.a101.fakediary.randomexchangepool.entity.RandomExchangePool;
import com.a101.fakediary.randomexchangepool.repository.RandomExchangePoolRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
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

        Diary diary = diaryRepository.findById(diaryId).orElseThrow(() -> new Exception("diary not found!"));

        //  이미 교환된 일기가 들어왔을 경우
        if(diary.isExchanged())
            throw new Exception("diary is already exchanged!");

        Member owner = memberRepository.findById(ownerId).orElseThrow(() -> new Exception("owner not found!"));

        RandomExchangePool randomExchangePool = RandomExchangePool.builder()
                .diary(diary)
                .owner(owner)
                .randomDate(LocalDate.now())
                .build();

        randomExchangePoolRepository.save(randomExchangePool);

        return createRandomExchangePoolResponseDto(randomExchangePool);
    }

    @Transactional
    public void doRandomMatching() {
        List<RandomExchangePoolResponseDto> randomExchangePoolResponseDtoList = getRandomExchangePoolResponseList();
        int size = randomExchangePoolResponseDtoList.size();    //  랜덤 요청 개수
        int idx = 0;

        if(size >= 2) {
            for (; idx < size - 2; idx += 2) {
                RandomExchangePoolResponseDto reprDto1 = randomExchangePoolResponseDtoList.get(idx);
                RandomExchangePoolResponseDto reprDto2 = randomExchangePoolResponseDtoList.get(idx + 1);

                RandomExchangePoolUpdateDto repuDto1 = RandomExchangePoolUpdateDto.builder()
                        .randomId(reprDto1.getRandomExchangePoolId())
                        .exchangedDiaryId(reprDto2.getDiaryId())
                        .exchangedOwnerId(reprDto2.getExchangedOwnerId())
                        .build();

                RandomExchangePoolUpdateDto repuDto2 = RandomExchangePoolUpdateDto.builder()
                        .randomId(reprDto2.getRandomExchangePoolId())
                        .exchangedDiaryId(reprDto1.getDiaryId())
                        .exchangedOwnerId(reprDto1.getExchangedOwnerId())
                        .build();

            }
        }
    }

    @Transactional(readOnly = true)
    public List<RandomExchangePoolResponseDto> getRandomExchangePoolResponseList() {
        //  어제 생성된 모든 요청들을 가져옴
        List<RandomExchangePool> randomExchangePoolList = randomExchangePoolRepository.findAllCreatedYesterday();
        List<RandomExchangePoolResponseDto> ret = new ArrayList<>();

        for(RandomExchangePool randomExchangePool : randomExchangePoolList) {
            ret.add(createRandomExchangePoolResponseDto(randomExchangePool));
        }

        return ret;
    }

    /**
     * 랜덤 매칭 성사 후 DB에 매칭 결과 저장
     * @param randomExchangePoolUpdateDto
     * @return
     * @throws Exception
     */
    @Transactional
    public RandomExchangePoolResponseDto updateRandomExchangePool
            (RandomExchangePoolUpdateDto randomExchangePoolUpdateDto) throws Exception {
        RandomExchangePool randomExchangePool = randomExchangePoolRepository.findById(randomExchangePoolUpdateDto.getRandomId())
                .orElseThrow(() -> new Exception("random exchange not found!"));
        Diary exchangedDiary = diaryRepository.findById(randomExchangePoolUpdateDto.getExchangedDiaryId())
                .orElseThrow(() -> new Exception("exchanged diary not found!"));
        Member exchangedOwner = memberRepository.findById(randomExchangePoolUpdateDto.getExchangedOwnerId())
                .orElseThrow(() -> new Exception("exchanged owner not found!"));

        randomExchangePool.setExchangedDiary(exchangedDiary);
        randomExchangePool.setExchangedOwner(exchangedOwner);

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
