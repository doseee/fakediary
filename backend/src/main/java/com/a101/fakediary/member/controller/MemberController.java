package com.a101.fakediary.member.controller;

import com.a101.fakediary.member.dto.MemberLoginRequestDto;
import com.a101.fakediary.member.dto.MemberSaveRequestDto;
import com.a101.fakediary.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RequestMapping("/member")
@RestController
public class MemberController {

    private final MemberService memberService;

    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@RequestBody MemberSaveRequestDto memberSaveRequestDto){
        System.out.println("하이");
        if(memberSaveRequestDto == null){
            return ResponseEntity.badRequest().body("MemberSaveRequestDto is null");
        }
        return memberService.MemberSignUp(memberSaveRequestDto);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String email, @RequestParam String password){

        return memberService.MemberLogin(email, password);
    }



}
