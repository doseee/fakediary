package com.a101.fakediary.music.service;

import com.a101.fakediary.music.dto.MusicResponseDto;
import com.a101.fakediary.music.entity.Music;
import com.a101.fakediary.music.repository.MusicRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class MusicService {
    private final MusicRepository musicRepository;
    
    /**
     * 어제 또는 오늘 크롤링한 음악 중 장르가 mood에 해당하는 음악의 리스트를 가져옴
     * @param mood
     * @return
     */
    @Transactional(readOnly = true)
    public List<MusicResponseDto> getMusicsByMood(String mood) {
        return musicRepository.getMusicsByMoodAndUploadDate(mood, LocalDate.now());
    }

    /**
     * 파일명이 fileName, URL이 musicUrl인 음악을 DB에 저장함
     * @param fileName
     * @param musicUrl
     * @return
     */
    @Transactional(propagation = Propagation.NOT_SUPPORTED) //  트랜잭셔널 해제해서 음악별로 바로바로 일기생성되도록함
    public MusicResponseDto saveMusic(String fileName, String musicUrl, String mood) {
        Music music = Music.builder()
                .fileName(fileName)
                .musicUrl(musicUrl)
                .mood(mood)
                .uploadDate(LocalDate.now())
                .build();

        musicRepository.save(music);

        log.info("저장된 음악 = " + music);

        return new MusicResponseDto(music);
    }
}
