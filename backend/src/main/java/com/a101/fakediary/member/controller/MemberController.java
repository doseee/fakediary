package com.a101.fakediary.member.controller;

import com.a101.fakediary.member.dto.MemberSaveRequestDto;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.a101.fakediary.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RequiredArgsConstructor
@RequestMapping("/member")
@RestController
public class MemberController {

    private final MemberService memberService;
    private final MemberRepository memberRepository;

    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@RequestBody MemberSaveRequestDto memberSaveRequestDto){

        if(memberSaveRequestDto == null){
            return ResponseEntity.badRequest().body("MemberSaveRequestDto is null");
        }
        return memberService.signUpMember(memberSaveRequestDto);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String email, @RequestParam String password){

        return memberService.signInMember(email, password);
    }

//    @PatchMapping("/{id}")
//    public ResponseEntity<?> updateMember(@PathVariable Long id, @RequestBody MemberUpdateRequestDto requestDto) {
//        boolean isNicknameUnique = memberService.isNicknameUnique(requestDto.getNickname());
//        if (!isNicknameUnique) {
//            return ResponseEntity.badRequest().body("Nickname already exists.");
//        }
//
//        Optional<Member> member = memberService.findMemberById(id);
//        if (member.isPresent()) {
//            memberService.updateMember(id, requestDto);
//            return ResponseEntity.ok().build();
//        } else {
//            return ResponseEntity.notFound().build();
//        }
//    }
    @DeleteMapping("/{memberId}")
    public ResponseEntity<?> deleteMember(@PathVariable Long memberId){

        Optional<Member> memberOptional = memberRepository.findById(memberId);
        if (memberOptional.isEmpty()) {
            return ResponseEntity.badRequest().body("Invalid memberId");
        }

        return memberService.removeMember(memberId);
    }



}
