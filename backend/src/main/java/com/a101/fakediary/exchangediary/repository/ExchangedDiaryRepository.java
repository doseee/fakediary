package com.a101.fakediary.exchangediary.repository;

import com.a101.fakediary.exchangediary.entity.ExchangedDiary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExchangedDiaryRepository extends JpaRepository<ExchangedDiary, Long> {
}
