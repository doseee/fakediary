package com.a101.fakediary.member.controller;

import com.a101.fakediary.member.dto.MemberLoginRequestDto;
import com.a101.fakediary.member.dto.MemberSaveRequestDto;
import com.a101.fakediary.member.dto.MemberUpdateRequestDto;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.a101.fakediary.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RequiredArgsConstructor
@RequestMapping("/member")
@RestController
public class MemberController {

    private final MemberService memberService;
    private final MemberRepository memberRepository;

    //회원가입
    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@RequestBody MemberSaveRequestDto memberSaveRequestDto) {

//        if (memberSaveRequestDto == null) {
//            return ResponseEntity.badRequest().body("MemberSaveRequestDto is null");
//        }
        return memberService.signUpMember(memberSaveRequestDto);
    }

    //로그인
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody MemberLoginRequestDto memberLoginRequestDto) {
        //프론트쪽에서 로그인 성공시 닉네임을 반환해달라는 요청
        ResponseEntity<?> response = memberService.signInMember(memberLoginRequestDto);
        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
            Member member = (Member) response.getBody();
            if (member.getNickname() != null) {
                return ResponseEntity.ok(member.getNickname());
            }
        }
        return response;
    }

    //회원 정보 수정
    @PatchMapping("/{memberId}")
    public ResponseEntity<?> updateMember(@PathVariable Long memberId,
                                          @RequestBody MemberUpdateRequestDto memberUpdateRequestDto) {
        //memberId 검증
        Optional<Member> member = memberRepository.findById(memberId);
        if (member.isEmpty()) {
            return ResponseEntity.badRequest().body("존재하지 않는 id입니다");
        }

        try {
            memberService.modifyMember(memberId, memberUpdateRequestDto);
            return ResponseEntity.ok().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    //회원 삭제
    @DeleteMapping("/{memberId}")
    public ResponseEntity<?> deleteMember(@PathVariable Long memberId) {
        try {
            memberService.removeMember(memberId);
            return ResponseEntity.ok().build();
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
