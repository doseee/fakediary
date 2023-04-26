package com.a101.fakediary.member.service;

import com.a101.fakediary.member.dto.MemberLoginRequestDto;
import com.a101.fakediary.member.dto.MemberSaveRequestDto;
import com.a101.fakediary.member.dto.MemberUpdateRequestDto;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {
    private final MemberRepository memberRepository;

    //회원가입
    public ResponseEntity<?> signUpMember(MemberSaveRequestDto memberSaveRequestDto) {
        Map<String, String> response = new HashMap<>();
        // 닉네임 중복 체크
        if (memberRepository.existsByNickname(memberSaveRequestDto.getNickname())) {
            response.put("error", "이미 존재하는 닉네임입니다.");
            return ResponseEntity.badRequest().body(response);
        }
        // 이메일 중복 체크
        if (memberRepository.existsByEmail(memberSaveRequestDto.getEmail())) {
            response.put("error", "이미 존재하는 이메일입니다.");
            return ResponseEntity.badRequest().body(response);
        }

        Member member = memberSaveRequestDto.toEntity();
        String encodePassword = PasswordEncoder.sha256(member.getPassword()); // 시큐리티삭제해서 일단 Bcrypt대신 sha암호화
        member.setPassword(encodePassword);

        memberRepository.save(member);
        return ResponseEntity.ok().build();
    }

    //로그인
    public ResponseEntity<?> signInMember(MemberLoginRequestDto memberloginRequestDto) {
        Optional<Member> memberOptional = memberRepository.findByEmail(memberloginRequestDto.getEmail());
        if (!memberOptional.isPresent()) {
            return ResponseEntity.badRequest().body("Invalid email or password");
        }

        Member member = memberOptional.get();
        String encodePassword = PasswordEncoder.sha256(memberloginRequestDto.getPassword());
        if (!encodePassword.equals(member.getPassword())) {
            return ResponseEntity.badRequest().body("Invalid email or password");
        }
        return ResponseEntity.ok(member);
    }

    // 수정
    @Transactional
    public void modifyMember(Long memberId, MemberUpdateRequestDto memberUpdateRequestDto) {

        // 닉네임 중복 체크
        if (memberUpdateRequestDto.getNickname() != null) {
            Optional<Member> memberOptional = memberRepository.findByNickname(memberUpdateRequestDto.getNickname());
            if (memberOptional.isPresent() && !memberOptional.get().getMemberId().equals(memberId)) {
                throw new IllegalArgumentException("이미 존재하는 닉네임입니다.");
            }
        }

        Member member = memberRepository.findById(memberId).orElseThrow(() -> new IllegalArgumentException("Member not found"));

        // 회원 정보 수정
        if (memberUpdateRequestDto.getNickname() != null) {
            member.setNickname(memberUpdateRequestDto.getNickname());
        }
        member.setAutoDiaryTime(memberUpdateRequestDto.getAutoDiaryTime());
        member.setDiaryBaseName(memberUpdateRequestDto.getDiaryBaseName());
    }

    //삭제
    public ResponseEntity<?> removeMember(long memberId) {
        memberRepository.deleteById(memberId);
        return ResponseEntity.ok().build();
    }


}
