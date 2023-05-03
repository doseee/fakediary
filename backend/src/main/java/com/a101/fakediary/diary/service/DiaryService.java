package com.a101.fakediary.diary.service;

import com.a101.fakediary.diary.dto.DiaryFilterDto;
import com.a101.fakediary.diary.dto.DiaryRequestDto;
import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryQueryRepository;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.enums.EGenre;
import com.a101.fakediary.genre.dto.GenreDto;
import com.a101.fakediary.genre.repository.GenreRepository;
import com.a101.fakediary.genre.service.GenreService;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class DiaryService {

    private final DiaryRepository diaryRepository;
    private final MemberRepository memberRepository;
    private final GenreService genreService;
    private final DiaryQueryRepository diaryQueryRepository;

    public Diary toEntity(DiaryRequestDto dto) {
        return Diary.builder()
                .member(memberRepository.findByMemberId(dto.getMemberId()))
                .keyword(dto.getKeyword())
                .prompt(dto.getPrompt())
                .title(dto.getTitle())
                .detail(dto.getDetail())
                .summary(dto.getSummary())
                .build();
    }

    public List<DiaryResponseDto> changeResponse(List<Diary> diary) {
        List<DiaryResponseDto> list = new ArrayList<>();
        for (int i = 0; i < diary.size(); i++) {
            DiaryResponseDto tmp = new DiaryResponseDto(diary.get(i));
            tmp.setGenre(EGenre.valueOf(genreService.searchGenre(tmp.getDiaryId())));
            list.add(tmp);
        }
        return list;
    }

    public void saveDiary(DiaryRequestDto dto) {
        Diary diary = diaryRepository.save(toEntity(dto)); //일기 저장
        String[] s = dto.getGenre();

        for (int i = 0; i < s.length; i++) {
            GenreDto gen = new GenreDto(diary.getDiaryId(), s[i]);
            genreService.saveGenre(gen); //장르 저장
        }
    }

    public DiaryResponseDto detailDiary(Long diaryId) {
        return new DiaryResponseDto(diaryRepository.findByDiaryId(diaryId));
    }

    public List<DiaryResponseDto> allDiary(Long memberId) {
        List<Diary> diary = diaryRepository.allDiary(memberId);
        return changeResponse(diary);
    }

    public List<DiaryResponseDto> filterDiary(DiaryFilterDto filter) {//선택한 memberId, 요청한 memberId, 장르
        List<Diary> diary = diaryQueryRepository.searchDiaryByFilter(filter);
        return changeResponse(diary);
    }

    public void deleteDiary(Long diaryId) {
        genreService.deleteGenre(diaryId);
        diaryRepository.deleteDiary(diaryId);
    }
}