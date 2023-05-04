package com.a101.fakediary.diary.service;

import com.a101.fakediary.card.dto.response.CardMadeDiaryResponseDto;
import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.carddiarymapping.service.CardDiaryMappingService;
import com.a101.fakediary.diary.dto.DiaryFilterDto;
import com.a101.fakediary.diary.dto.DiaryRequestDto;
import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryQueryRepository;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.diaryimage.service.DiaryImageService;
import com.a101.fakediary.enums.EGenre;
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
    private final DiaryQueryRepository diaryQueryRepository;

    private Diary toEntity(DiaryRequestDto dto) {
        return Diary.builder()
                .member(memberRepository.findByMemberId(dto.getMemberId()))
                .keyword(dto.getKeyword()) // 받아온 카드리스트기반으로 키워드 추출
                .characters(dto.getCharacters())
                .places(dto.getPlaces())
                .prompt(dto.getPrompt()) //프론트GPT
                .title(dto.getTitle()) //프론트GPT
                .detail(dto.getDetail()) //프론트GPT
                .summary(dto.getSummary()) //프론트GPT
                .build();
    }

    private List<DiaryResponseDto> changeResponse(List<Diary> diary) {
        List<DiaryResponseDto> list = new ArrayList<>();
        for (Diary value : diary) {
            DiaryResponseDto tmp = new DiaryResponseDto(value);
            List<String> genre = genreService.searchGenre(tmp.getDiaryId());
            EGenre[] eGenres = new EGenre[genre.size()];
            int i = 0;
            for (String s : genre)
                eGenres[i++] = EGenre.valueOf(s);
            tmp.setGenre(eGenres);
            list.add(tmp);
        }
        return list;
    }

    @Transactional
    public Diary createDiary(DiaryRequestDto dto) {
        //dto 키워드 채우기
        StringBuilder keywords = new StringBuilder();
        StringBuilder names = new StringBuilder();
        StringBuilder places = new StringBuilder();

        List<Long> cardIds = dto.getCardIds();
        for (Long id : cardIds) {
            Card card = cardRepository.findById(id).orElseThrow();
            //빈것보냈을때 null로저장되는지 ""로저장되는지 확인필요 값이 존재하면 이어줌
            if (card.getKeyword() != null && !card.getKeyword().equals(""))
                keywords.append(card.getKeyword()).append("@"); //키워드@키워드@키워드@ 식으로 제작
            if (card.getBaseName() != null && !card.getBaseName().equals(""))
                names.append(card.getBaseName()).append("@");
            if (card.getBasePlace() != null && !card.getBasePlace().equals(""))
                places.append(card.getBasePlace()).append("@");
        }

        if (0 < keywords.length() && keywords.charAt(keywords.length() - 1) == '@') {
            keywords.deleteCharAt(keywords.length() - 1); // 마지막 골뱅이 제거
        }
        if (0 < names.length() && names.charAt(names.length() - 1) == '@') {
            names.deleteCharAt(names.length() - 1);
        }
        if (0 < places.length() && places.charAt(places.length() - 1) == '@') {
            places.deleteCharAt(places.length() - 1);
        }
        dto.setKeyword(keywords.toString());
        dto.setCharacters(names.toString());
        dto.setPlaces(places.toString());
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
        List<Diary> diary = diaryRepository.allDiary(memberId);
        return changeResponse(diary);
    }

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> filterDiary(DiaryFilterDto filter) {//선택한 memberId, 요청한 memberId, 장르
        List<Diary> diary = diaryQueryRepository.searchDiaryByFilter(filter);
        return changeResponse(diary);
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
    @Transactional(readOnly = true)
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

    @Transactional(readOnly = true)
    public List<DiaryResponseDto> getDiariesByCardId(Long cardId) throws Exception {
        List<Diary> diaries = diaryRepository.findDiariesByCardId(cardId).orElseThrow(() -> new Exception("cardId에 해당하는 일기 존재하지 않음"));
        List<DiaryResponseDto> ret = new ArrayList<>();

        for(Diary diary : diaries)
            ret.add(new DiaryResponseDto(diary));

        return ret;
    }
}