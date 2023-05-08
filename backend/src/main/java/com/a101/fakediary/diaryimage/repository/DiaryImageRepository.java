package com.a101.fakediary.diaryimage.repository;

import com.a101.fakediary.diaryimage.entity.DiaryImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiaryImageRepository extends JpaRepository<DiaryImage, Long> {
    @Query("select d.diaryImageUrl from DiaryImage d where d.diary.diaryId =:diaryId")
    String[] findByDiaryImageUrl(Long diaryId);
}
