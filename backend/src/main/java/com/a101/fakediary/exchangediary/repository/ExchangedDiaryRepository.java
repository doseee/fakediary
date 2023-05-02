package com.a101.fakediary.exchangediary.repository;

import com.a101.fakediary.exchangediary.dto.ExchangedResponseDiaryDto;
import com.a101.fakediary.exchangediary.entity.ExchangedDiary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExchangedDiaryRepository extends JpaRepository<ExchangedDiary, Long> {
    @Query("select new com.a101.fakediary.exchangediary.dto.ExchangedResponseDiaryDto(d) " +
            "from ExchangedDiary d " +
            "where d.sender.memberId =:senderId and d.receiver.memberId =:receiveOwnerId")
    List<ExchangedResponseDiaryDto> findExchangedDiary(@Param("senderId") Long senderId, @Param("receiveOwnerId") Long receiveOwnerId);
}
