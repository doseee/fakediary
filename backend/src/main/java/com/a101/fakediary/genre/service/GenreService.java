package com.a101.fakediary.genre.service;

import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.genre.dto.GenreDto;
import com.a101.fakediary.genre.entity.Genre;
import com.a101.fakediary.genre.entity.GenrePK;
import com.a101.fakediary.genre.repository.GenreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class GenreService {

    private final GenreRepository genreRepository;
    private final DiaryRepository diaryRepository;

    public Genre toEntity(GenreDto dto) {
        return Genre.builder()
                .id(new GenrePK(diaryRepository.findByDiaryId(dto.getDiaryId()), dto.getGenre()))
                .build();
    }

    public void saveGenre(GenreDto dto) {
        genreRepository.save(toEntity(dto));
    }
    public void deleteGenre(Long diaryId) {genreRepository.deleteGenre(diaryId);}
}
