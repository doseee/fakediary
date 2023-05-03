package com.a101.fakediary.member.controller;

import com.a101.fakediary.member.dto.*;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.a101.fakediary.member.service.MemberService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Api("Member Controller")
@RequiredArgsConstructor
@RequestMapping("/member")
@RestController
public class MemberController {

    private final MemberService memberService;
    private final MemberRepository memberRepository;

    //회원가입
    @ApiOperation(value = "유저 회원가입")
    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@RequestBody MemberSaveRequestDto memberSaveRequestDto) {
        try {
            Member member = memberService.signUpMember(memberSaveRequestDto);
            return ResponseEntity.ok(member);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    //로그인

    @ApiOperation(value = "유저 로그인")
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody MemberLoginRequestDto memberLoginRequestDto) {
        try {
            MemberLoginResponseDto memberLoginResponseDto = memberService.signInMember(memberLoginRequestDto);
            return ResponseEntity.ok().body(memberLoginResponseDto);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    //유저 조회
    @ApiOperation(value = "유저 조회")
    @GetMapping("/{memberId}")
    public ResponseEntity<?> getMember(@PathVariable Long memberId){
        try {
            MemberResponseDto memberResponseDto = memberService.findMember(memberId);
            return ResponseEntity.ok().body(memberResponseDto);
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    //회원 정보 수정
    @ApiOperation(value = "유저 정보 수정", notes = "authDiaryTime은 \"autoDiaryTime\" : \"23:00:00\" 이런식으로 입력" )
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
    @ApiOperation(value = "유저 삭제")
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
