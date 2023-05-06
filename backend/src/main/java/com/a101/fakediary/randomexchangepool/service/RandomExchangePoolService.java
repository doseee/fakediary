package com.a101.fakediary.randomexchangepool.service;

import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.diary.service.DiaryService;
import com.a101.fakediary.enums.EExchangeType;
import com.a101.fakediary.exchangediary.dto.request.ExchangedDiarySaveRequestDto;
import com.a101.fakediary.exchangediary.service.ExchangedDiaryService;
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
    private final DiaryService diaryService;
    private final ExchangedDiaryService exchangedDiaryService;

    @Transactional
    public RandomExchangePoolResponseDto registRandomExchange(RandomExchangePoolRegistDto randomExchangePoolRegistDto) throws Exception {
        Long diaryId = randomExchangePoolRegistDto.getDiaryId();
        Long ownerId = randomExchangePoolRegistDto.getOwnerId();

        Diary diary = diaryRepository.findById(diaryId).orElseThrow(() -> new Exception("diary not found!"));

        //  이미 교환된 일기가 들어왔을 경우
        if(diary.isExchanged())
            throw new Exception("diary is already exchanged!");

        Member owner = memberRepository.findById(ownerId).orElseThrow(() -> new Exception("owner not found!"));

        if(owner.isRandomExchanged())
            throw new Exception("이미 랜덤 교환을 요청한 회원입니다!");

        owner.setRandomExchanged(true); //  회원이 오늘 랜덤 교환을 신청한 상태로 변경(다음 날까지는 다시 신청 못함)
        diary.setExchanged(true);       //  일기가 이미 랜덤 교환에 사용됨. 다시는 사용될 수 없음

        RandomExchangePool randomExchangePool = RandomExchangePool.builder()
                .diary(diary)
                .owner(owner)
                .randomDate(LocalDate.now())
                .build();

        randomExchangePoolRepository.save(randomExchangePool);

        return createRandomExchangePoolResponseDto(randomExchangePool);
    }

    /**
     *
     * @throws Exception
     */
    @Transactional
    public void doRandomMatching() throws Exception {
        List<RandomExchangePoolResponseDto> randomExchangePoolResponseDtoList = getYesterdayRandomExchangePoolResponseList();
//        List<RandomExchangePoolResponseDto> randomExchangePoolResponseDtoList = getTodayRandomExchangePoolResponseList();

        log.info("randomExchangePoolResponseDtoList = " + randomExchangePoolResponseDtoList);

        int size = randomExchangePoolResponseDtoList.size();    //  랜덤 요청 개수
        int remainder = size % 2;
        int idx = 0;

        if(size >= 2) {
            for (; idx < size - 2; idx += 2) {
                RandomExchangePoolResponseDto reprDto1 = randomExchangePoolResponseDtoList.get(idx);
                RandomExchangePoolResponseDto reprDto2 = randomExchangePoolResponseDtoList.get(idx + 1);

                log.info("reprDto1 = " + reprDto1);
                log.info("reprDto2 = " + reprDto2);

                RandomExchangePoolUpdateDto repuDto1 = getRepuDto(reprDto1, reprDto2);
                RandomExchangePoolUpdateDto repuDto2 = getRepuDto(reprDto2, reprDto1);

                log.info("repuDto1 = " + repuDto1);
                log.info("repuDto2 = " + repuDto2);

                ExchangedDiarySaveRequestDto exchangeDiarySaveRequestDto1 = createEDSRDto(reprDto1, reprDto2);
                ExchangedDiarySaveRequestDto exchangeDiarySaveRequestDto2 = createEDSRDto(reprDto2, reprDto1);

                log.info("exchangeDiarySaveRequestDto1 = " + exchangeDiarySaveRequestDto1);
                log.info("exchangeDiarySaveRequestDto2 = " + exchangeDiarySaveRequestDto1);

                exchangedDiaryService.saveExchangeDiary(exchangeDiarySaveRequestDto1);
                exchangedDiaryService.saveExchangeDiary(exchangeDiarySaveRequestDto2);

                updateRandomExchangePool(repuDto1);
                updateRandomExchangePool(repuDto2);
            }
        }
        
        if(remainder == 1)  {    //  한 명이 남을 경우
            RandomExchangePoolResponseDto reprDto = randomExchangePoolResponseDtoList.get(size - 1);
            List<DiaryResponseDto> developersDiaries = diaryService.getDevelopersDiaries();
            Random ran = new Random();
            int index = ran.nextInt(developersDiaries.size());

            DiaryResponseDto developerDiary = developersDiaries.get(index);

            RandomExchangePoolUpdateDto repuDto = RandomExchangePoolUpdateDto.builder()
                    .randomExchangePoolId(reprDto.getRandomExchangePoolId())
                    .exchangedDiaryId(developerDiary.getDiaryId())
                    .exchangedOwnerId(developerDiary.getMemberId())
                    .build();

            ExchangedDiarySaveRequestDto exchangeDiarySaveRequestDto = ExchangedDiarySaveRequestDto.builder()
                    .sendDiaryId(reprDto.getDiaryId())
                    .senderId(reprDto.getOwnerId())
                    .receiveDiaryId(developerDiary.getDiaryId())
                    .receiverId(developerDiary.getMemberId())
                    .friendExchangeType(EExchangeType.R)
                    .build();

            exchangedDiaryService.saveExchangeDiary(exchangeDiarySaveRequestDto);

            updateRandomExchangePool(repuDto);
        }
    }

    @Transactional(readOnly = true)
    public List<RandomExchangePoolResponseDto> getYesterdayRandomExchangePoolResponseList() {
        //  어제 생성된 모든 요청들을 가져옴
        List<RandomExchangePool> randomExchangePoolList = randomExchangePoolRepository.findAllCreatedYesterday();
        List<RandomExchangePoolResponseDto> ret = new ArrayList<>();

        for(RandomExchangePool randomExchangePool : randomExchangePoolList) {
            ret.add(createRandomExchangePoolResponseDto(randomExchangePool));
        }

        return ret;
    }

    @Transactional(readOnly = true)
    public List<RandomExchangePoolResponseDto> getTodayRandomExchangePoolResponseList() {
        //  어제 생성된 모든 요청들을 가져옴
        List<RandomExchangePool> randomExchangePoolList = randomExchangePoolRepository.findAllCreatedToday();
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
        RandomExchangePool randomExchangePool = randomExchangePoolRepository.findById(randomExchangePoolUpdateDto.getRandomExchangePoolId())
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

    private RandomExchangePoolUpdateDto getRepuDto(RandomExchangePoolResponseDto reprDto1, RandomExchangePoolResponseDto reprDto2) {
        return RandomExchangePoolUpdateDto.builder()
                .randomExchangePoolId(reprDto1.getRandomExchangePoolId())
                .exchangedDiaryId(reprDto2.getDiaryId())
                .exchangedOwnerId(reprDto2.getOwnerId())
                .build();
    }

    private ExchangedDiarySaveRequestDto createEDSRDto(RandomExchangePoolResponseDto reprDto1, RandomExchangePoolResponseDto reprDto2) {
        return ExchangedDiarySaveRequestDto.builder()
                .sendDiaryId(reprDto1.getDiaryId())
                .senderId(reprDto1.getOwnerId())
                .receiveDiaryId(reprDto2.getDiaryId())
                .receiverId(reprDto2.getOwnerId())
                .friendExchangeType(EExchangeType.R)
                .build();
    }
}
