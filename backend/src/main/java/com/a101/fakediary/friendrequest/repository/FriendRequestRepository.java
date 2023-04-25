package com.a101.fakediary.friendrequest.repository;

import com.a101.fakediary.friendrequest.entity.FriendRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FriendRequestRepository extends JpaRepository<FriendRequest, Long> {
    FriendRequest findByFriendRequestId(Long friendRequestId);
}
