package com.a101.fakediary.friendship.repository;

import com.a101.fakediary.friendship.entity.Friendship;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FriendshipRepository extends JpaRepository<Friendship, Long> {
}
