package com.a101.fakediary.music.repository;

import com.a101.fakediary.music.dto.MusicResponseDto;
import com.a101.fakediary.music.entity.Music;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface MusicRepository extends JpaRepository<Music, Long> {
    /**
     *
     * @param uploadDate : 음악이 업로드된 날짜
     * @param mood : 찾으려는 음악 무드
     * @return
     */
    @Query("SELECT new com.a101.fakediary.music.dto.MusicResponseDto(m)" +
            "FROM Music m WHERE (m.uploadDate = :uploadDate OR m.uploadDate = :previousDate) AND m.mood = :mood")
    List<MusicResponseDto> getMusicsByMood(@Param("mood") String mood, @Param("uploadDate") LocalDate uploadDate, @Param("previousDate") LocalDate previousDate);

    default List<MusicResponseDto> getMusicsByMoodAndUploadDate(@Param("mood") String mood, @Param("uploadDate") LocalDate uploadDate) {
        LocalDate previousDate = uploadDate.minusDays(1);   //  어제 날짜
        return getMusicsByMood(mood, uploadDate, previousDate);
    }
}
