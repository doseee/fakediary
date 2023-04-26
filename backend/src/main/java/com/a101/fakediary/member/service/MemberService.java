package com.a101.fakediary.member.service;

import com.a101.fakediary.member.dto.MemberSaveRequestDto;
import com.a101.fakediary.member.dto.MemberUpdateRequestDto;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {
    private final MemberRepository memberRepository;

    //회원가입
    public ResponseEntity<?> signUpMember(MemberSaveRequestDto memberSaveRequestDto) {
        Member member = memberSaveRequestDto.toEntity();
        String encodePassword = PasswordEncoder.sha256(member.getPassword()); // 시큐리티삭제해서 일단 Bcrypt대신 sha암호화
        member.setPassword(encodePassword);

        memberRepository.save(member);
        return ResponseEntity.ok().build();
    }

    //로그인
    public ResponseEntity<?> signInMember(String email, String password) {
        Optional<Member> memberOptional = memberRepository.findByEmail(email);
        if (!memberOptional.isPresent()) {
            return ResponseEntity.badRequest().body("Invalid email or password");
        }

        Member member = memberOptional.get();
        String encodePassword = PasswordEncoder.sha256(password);
        if (!encodePassword.equals(member.getPassword())) {
            return ResponseEntity.badRequest().body("Invalid email or password");
        }
        return ResponseEntity.ok().build();
    }

//    public boolean isNicknameUnique(String nickname) {
//        return !memberRepository.existsByNickname(nickname);
//    }

    // 수정
//    @Transactional
//    public void updateMember(Long id, MemberUpdateRequestDto requestDto) {
//        Optional<Member> member = memberRepository.findById(id);
//        if (member.isPresent()) {
//            Member m = member.get();
//            m.setNickname(requestDto.getNickname());
//            m.setAutoDiaryTime(requestDto.getAutoDiaryTime());
//            m.setDiaryBaseName(requestDto.getDiaryBaseName());
//        }
//    }

    //삭제
    public ResponseEntity<?> removeMember(long memberId) {
        memberRepository.deleteById(memberId);
        return ResponseEntity.ok().build();
    }


}
