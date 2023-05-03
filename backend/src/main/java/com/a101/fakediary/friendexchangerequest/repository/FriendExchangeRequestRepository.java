package com.a101.fakediary.friendexchangerequest.repository;

import com.a101.fakediary.friendexchangerequest.entity.FriendExchangeRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FriendExchangeRequestRepository extends JpaRepository<FriendExchangeRequest, Long> {
    FriendExchangeRequest findByfriendExchangeRequestId(Long friendExchangeRequestId);
}
