package com.a101.fakediary.member.service;

import com.a101.fakediary.member.dto.MemberSaveRequestDto;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {
    private final MemberRepository memberRepository;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    //회원가입
    public ResponseEntity<?> MemberSignUp(MemberSaveRequestDto memberSaveRequestDto) {
        Member member = memberSaveRequestDto.toEntity();
        String encodePassword = passwordEncoder.encode(member.getPassword());
        member.setPassword(encodePassword);

        memberRepository.save(member);
        return ResponseEntity.ok().build();
    }

    //로그인
    public ResponseEntity<?> MemberLogin(String email, String password){
        Optional<Member> memberOptional = memberRepository.findByEmail(email);
        if(!memberOptional.isPresent()){
            return ResponseEntity.badRequest().body("Invalid email or password");
        }

        Member member = memberOptional.get();
        if (!passwordEncoder.matches(password, member.getPassword())){
            return ResponseEntity.badRequest().body("Invalid email or password");
        }

        return ResponseEntity.ok().build();
    }

}
