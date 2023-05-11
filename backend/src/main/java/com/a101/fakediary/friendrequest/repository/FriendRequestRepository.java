package com.a101.fakediary.friendrequest.repository;

import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.friendrequest.entity.FriendRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FriendRequestRepository extends JpaRepository<FriendRequest, Long> {
    @Query("select f from FriendRequest f where f.senderId.memberId =:senderId and f.receiverId.memberId =:receiverId")
    FriendRequest checkDuplicate(Long senderId, Long receiverId);

    @Query(name="AlarmResponseQuery", nativeQuery = true)
    List<AlarmResponseDto> listAlarm(Long memberId);
}
