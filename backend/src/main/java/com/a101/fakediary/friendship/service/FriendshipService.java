package com.a101.fakediary.friendship.service;

import com.a101.fakediary.friendship.dto.FriendshipDto;
import com.a101.fakediary.friendship.entity.Friendship;
import com.a101.fakediary.friendship.repository.FriendshipRepository;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class FriendshipService {

    private final FriendshipRepository friendshipRepository;
    private final MemberRepository memberRepository;

    public void saveFriend(FriendshipDto dto) {
        friendshipRepository.save(dto.toEntity()); // A,B 저장
        dto.setFriendId(dto.getMemberId());
        dto.setMemberId(dto.getFriendId());
        friendshipRepository.save(dto.toEntity()); // B,A 저장
    }

    public void deleteFriend(FriendshipDto dto) {
        friendshipRepository.deleteById(dto.getFriendId());
        friendshipRepository.deleteById(dto.getMemberId());
    }

    public List<Member> searchFriend(String nickname) {
        return memberRepository.findByNicknameContaining(nickname);
    }

    public List<Friendship> listFriend(Long memberId) {
        return friendshipRepository.findByMemberId(memberId);
    }
}
