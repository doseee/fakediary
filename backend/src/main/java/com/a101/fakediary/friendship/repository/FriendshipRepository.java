package com.a101.fakediary.friendship.repository;

import com.a101.fakediary.friendship.entity.Friendship;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FriendshipRepository extends JpaRepository<Friendship, Long> {
    List<Friendship> findByMemberId(Long memberId);
}
