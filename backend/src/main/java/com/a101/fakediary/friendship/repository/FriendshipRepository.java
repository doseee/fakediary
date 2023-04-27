package com.a101.fakediary.friendship.repository;

import com.a101.fakediary.friendship.dto.FriendshipResponseDto;
import com.a101.fakediary.friendship.entity.Friendship;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface FriendshipRepository extends JpaRepository<Friendship, Long> {
    @Query(name="listFriendQuery", nativeQuery = true)
    List<FriendshipResponseDto> listFriend(Long memberId);
    @Modifying
    @Transactional
    @Query("delete from Friendship where memberId =:memberId and friendId =:friendId")
    void deleteFriend(@Param("memberId") Long memberId, @Param("friendId") Long friendId);
}
