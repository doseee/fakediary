package com.a101.fakediary.diary.repository;

import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.entity.Diary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface DiaryRepository extends JpaRepository<Diary, Long> {
    Diary findByDiaryId(Long diaryId);

    @Query("select new com.a101.fakediary.diary.dto.DiaryResponseDto(d) " +
            "from Diary d " +
            "where d.member.memberId =:memberId")
    List<DiaryResponseDto> allDiary(Long memberId);

    @Query("select new com.a101.fakediary.diary.dto.DiaryResponseDto(d) " +
            "from Diary d , Genre g " +
            "where d.member.memberId =:memberId and d.diaryId = g.id.diary.diaryId and g.id.genre =:genre")
    List<DiaryResponseDto> filterDiary(@Param("memberId") Long memberId, @Param("genre") String genre);

    @Modifying
    @Transactional
    @Query("delete from Diary where diaryId =:diaryId")
    void deleteDiary(@Param("diaryId") Long diaryId);

    /**
     * 개발자가 생성해둔 Dummy 일기 리스트들을 가져옴
     *
     * @return
     */
    @Query("SELECT new com.a101.fakediary.diary.dto.DiaryResponseDto(d)" +
            "FROM Diary d WHERE d.diaryId >= 0 AND d.diaryId < 1000 ORDER BY RAND()")
    List<DiaryResponseDto> getDevelopersDiaries();

    //다이어리 id의 이미지들을 오름차순으로 정렬. 가장 앞에있는것이 썸네일
    @Query("SELECT d.diaryImageUrl FROM DiaryImage d WHERE d.diary.diaryId = :diaryId ORDER BY d.diaryImageId ASC")
    List<String> findDiaryImageUrlByDiaryId(@Param("diaryId") Long diaryId);
}