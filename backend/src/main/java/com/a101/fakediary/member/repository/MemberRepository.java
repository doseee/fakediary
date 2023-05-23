package com.a101.fakediary.member.repository;

import com.a101.fakediary.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
    Member findByMemberId(Long memberId);
    Optional<Member> findByEmail(String email);
    Optional<Member> findByKakaoUid(Long kakaoUid);
    boolean existsByNickname(String nickname);
    boolean existsByEmail(String email);
    boolean existsByKakaoUid(Long kakaoUid);
    Optional<Member> findByNickname(String nickname);
    @Query("SELECT m FROM Member m WHERE HOUR(m.autoDiaryTime) = ?1 AND MINUTE(m.autoDiaryTime) = ?2")
    List<Member> findByAutoDiaryTimeHourAndMinute(int hour, int minute);
}
