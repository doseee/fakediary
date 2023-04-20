package com.a101.fakediary.randomexchangepool.repository;

import com.a101.fakediary.randomexchangepool.entity.RandomExchangePool;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RandomExchangePoolRepository extends JpaRepository<RandomExchangePool, Long> {
}
