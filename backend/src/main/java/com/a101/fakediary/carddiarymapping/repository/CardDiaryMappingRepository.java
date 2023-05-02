package com.a101.fakediary.carddiarymapping.repository;

import com.a101.fakediary.carddiarymapping.entity.CardDiaryMapping;
import com.a101.fakediary.carddiarymapping.entity.CardDiaryMappingPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CardDiaryMappingRepository extends JpaRepository<CardDiaryMapping, CardDiaryMappingPK>{

    //cardId와 함께 복합키를 구성하는 diaryId 리스트 반환
    @Query("SELECT mapping.id.diary.diaryId FROM CardDiaryMapping mapping WHERE mapping.id.card.cardId = :cardId")
    List<Long> findDiaryIdsByCardId(@Param("cardId") Long cardId);
}
