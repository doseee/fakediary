package com.a101.fakediary.member.repository;

import com.a101.fakediary.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
    Member findByMemberId(Long memberId);
    List<Member> findByNicknameContaining(String nickname);
}
