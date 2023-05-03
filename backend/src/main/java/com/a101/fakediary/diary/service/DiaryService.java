package com.a101.fakediary.diary.service;

import com.a101.fakediary.card.dto.response.CardMadeDiaryResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.carddiarymapping.service.CardDiaryMappingService;
import com.a101.fakediary.diary.dto.DiaryRequestDto;
import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.diaryimage.service.DiaryImageService;
import com.a101.fakediary.genre.dto.GenreDto;
import com.a101.fakediary.genre.service.GenreService;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class DiaryService {

    private final DiaryRepository diaryRepository;
    private final MemberRepository memberRepository;
    private final GenreService genreService;
    private final DiaryRepository diaryImageRepository;
    private final CardDiaryMappingService cardDiaryMappingService;
    private final CardRepository cardRepository;
    private final DiaryImageService diaryImageService;

    public Diary toEntity(DiaryRequestDto dto) {
        return Diary.builder()
                .member(memberRepository.findByMemberId(dto.getMemberId()))
                .keyword(dto.getKeyword()) // 받아온 카드리스트기반으로 키워드 추출
                .prompt(dto.getPrompt()) //프론트GPT
                .title(dto.getTitle()) //프론트GPT
                .detail(dto.getDetail()) //프론트GPT
                .summary(dto.getSummary()) //프론트GPT
                .build();
    }

    @Transactional
    public Diary createDiary(DiaryRequestDto dto) {

        //dto 키워드 채우기
        StringBuilder keyword = new StringBuilder();

        List<Long> cardIds = dto.getCardIds();
        for(Long id : cardIds){
            Card card = cardRepository.findById(id).orElseThrow();
            keyword.append(card.getKeyword()).append("@"); //키워드@키워드@키워드@ 식으로 제작
        }
        keyword.deleteCharAt(keyword.length()-1);//마지막 골뱅이 제거
        if (0 < keyword.length() && keyword.charAt(keyword.length() -1) == '@'){
            keyword.deleteCharAt(keyword.length() - 1); // 마지막 골뱅이 제거
        }
        dto.setKeyword(keyword.toString());
        //dto 키워드 채우기 end


        //GPT API날려서 dto내용채우고하려했는데 일단은 프론트쪽에서 하는것으로.

        //일기 생성
        Diary diary = diaryRepository.save(toEntity(dto));

        //장르 테이블 생성
        List<String> genreList = dto.getGenre();

        for (String genre : genreList) {
            GenreDto gen = new GenreDto(diary.getDiaryId(), genre);
            genreService.saveGenre(gen); //장르 저장
        }

        // 카드&일기 매핑테이블 생성
            cardDiaryMappingService.createCardDiaryMappings(diary.getDiaryId(), cardIds);

        //일기&이미지파일 테이블 만들기 프론트에서 url받아왔다 가정
        diaryImageService.createDiaryImages(diary.getDiaryId(), dto.getDiaryImageUrl());

        return diary;
    }

    @Transactional(readOnly = true)
    public DiaryResponseDto detailDiary(Long diaryId) {
        return new DiaryResponseDto(diaryRepository.findByDiaryId(diaryId));
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> allDiary(Long memberId) {
        return diaryRepository.allDiary(memberId);
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> filterDiary(Long memberId, String genre) {
        return diaryRepository.filterDiary(memberId, genre);
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> getDevelopersDiaries() {
        return diaryRepository.getDevelopersDiaries();
    }

    @Transactional
    public void deleteDiary(Long diaryId) {
        genreService.deleteGenre(diaryId);
        diaryRepository.deleteDiary(diaryId);
    }

    //카드Id리스트로부터 만들어진 다이어리 리스트 반환
    public List<CardMadeDiaryResponseDto> findDiaryListFromCardList(List<Long> diaryIdList) {
        List<CardMadeDiaryResponseDto> returnList = new ArrayList<CardMadeDiaryResponseDto>();
        for (Long diaryId : diaryIdList) {
            Diary diary = diaryRepository.findByDiaryId(diaryId);
            List<String> diaryImageUrls = diaryImageRepository.findDiaryImageUrlByDiaryId(diaryId);
            String diaryThumbnail = diaryImageUrls.stream().findFirst().orElse("이미지가 없습니다.");//썸네일
            CardMadeDiaryResponseDto dto = new CardMadeDiaryResponseDto().builder()
                    .diaryId(diary.getDiaryId())
                    .title((diary.getTitle()))
                    .subtitles(diary.getSubtitles())
                    .summary(diary.getSummary())
                    .diaryImageUrl(diaryThumbnail)
                    .characters(diary.getCharacters())
                    .places(diary.getPlaces())
                    .keyword(diary.getKeyword())
                    .createdAt(diary.getCreatedAt())
                    .build();
            returnList.add(dto);
        }
        return returnList;

    }
}