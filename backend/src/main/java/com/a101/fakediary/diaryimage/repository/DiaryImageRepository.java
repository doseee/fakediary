package com.a101.fakediary.diaryimage.repository;

import com.a101.fakediary.diaryimage.entity.DiaryImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiaryImageRepository extends JpaRepository<DiaryImage, Long> {
}
