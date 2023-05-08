package com.a101.fakediary.randomexchangepool.repository;

import com.a101.fakediary.randomexchangepool.entity.RandomExchangePool;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RandomExchangePoolRepository extends JpaRepository<RandomExchangePool, Long> {
    /* 어제 날짜에 요청된 모든 랜덤 교환 요청을 무작위로 섞어서 반환함 */
//    @Query("SELECT r FROM RandomExchangePool r WHERE FUNCTION('DATE', r.createdAt) = CURRENT_DATE - 2 ORDER BY RAND()")

//    select * from fakediary.random_exchange_pool where DATE(created_at) - 0 = DATE(now()) - 2;
    @Query("SELECT r FROM RandomExchangePool r WHERE DATE(r.randomDate) - 0 = DATE(now()) - 1 ORDER BY RAND()")
    List<RandomExchangePool> findAllCreatedYesterday();

    /* 오늘 날짜에 요청된 모든 랜덤 교환 요청을 무작위로 섞어서 반환함 */
//    @Query("SELECT r FROM RandomExchangePool r WHERE FUNCTION('DATE', r.createdAt) = CURRENT_DATE ORDER BY RAND()")
    @Query("SELECT r FROM RandomExchangePool r WHERE DATE(r.randomDate) - 0 = DATE(now()) - 0 ORDER BY RAND()")
    List<RandomExchangePool> findAllCreatedToday();
}
