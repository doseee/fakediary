package com.a101.fakediary.friendexchangerequest.repository;

import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.friendexchangerequest.entity.FriendExchangeRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
public interface FriendExchangeRequestRepository extends JpaRepository<FriendExchangeRequest, Long> {
    FriendExchangeRequest findByfriendExchangeRequestId(Long friendExchangeRequestId);
    FriendExchangeRequest findBySenderDiary_DiaryIdAndStatus(Long diaryId, ERequestStatus status);
}
