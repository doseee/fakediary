package com.a101.fakediary.diary.repository;

import com.a101.fakediary.diary.entity.Diary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface DiaryRepository extends JpaRepository<Diary, Long> {
    Diary findByDiaryId(Long diaryId);
}
