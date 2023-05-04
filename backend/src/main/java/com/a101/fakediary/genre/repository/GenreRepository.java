package com.a101.fakediary.genre.repository;

import com.a101.fakediary.enums.EGenre;
import com.a101.fakediary.genre.entity.Genre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface GenreRepository extends JpaRepository<Genre, Long>{
    @Modifying
    @Transactional
    @Query("delete from Genre where id.diary.diaryId =:diaryId")
    void deleteGenre(@Param("diaryId") Long diaryId);

    @Query("select g.id.genre from Genre g where g.id.diary.diaryId =:diaryId")
    List<String> findByDiaryId(Long diaryId);
}
