package com.a101.fakediary.genre.service;

import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.genre.dto.GenreDto;
import com.a101.fakediary.genre.entity.Genre;
import com.a101.fakediary.genre.entity.GenrePK;
import com.a101.fakediary.genre.repository.GenreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
@RequiredArgsConstructor
public class GenreService {

    private final GenreRepository genreRepository;
    private final DiaryRepository diaryRepository;

    @Transactional
    public void saveGenre(GenreDto dto) {
        genreRepository.save(toEntity(dto));
    }

    @Transactional
    public void deleteGenre(Long diaryId) {genreRepository.deleteGenre(diaryId);}

    @Transactional(readOnly = true)
    public List<String> searchGenre(Long diaryId) {
        return genreRepository.findByDiaryId(diaryId);
    }

    private Genre toEntity(GenreDto dto) {
        return Genre.builder()
                .id(new GenrePK(diaryRepository.findById(dto.getDiaryId()).orElseThrow(), dto.getGenre()))
                .build();
    }
}
