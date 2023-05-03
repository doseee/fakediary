package com.a101.fakediary.member.service;

import com.a101.fakediary.member.dto.*;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {
    private final MemberRepository memberRepository;

    //회원가입
    @Transactional
    public Member signUpMember(MemberSaveRequestDto memberSaveRequestDto) {
        // 닉네임 중복 체크
        if (memberRepository.existsByNickname(memberSaveRequestDto.getNickname())) {
            throw new IllegalArgumentException("이미 존재하는 닉네임입니다.");
        }
        // 이메일 중복 체크
        if (memberRepository.existsByEmail(memberSaveRequestDto.getEmail())) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }

        Member member = memberSaveRequestDto.toEntity();
        String encodePassword = PasswordEncoder.sha256(member.getPassword()); // 시큐리티삭제해서 일단 Bcrypt대신 sha암호화
        member.setPassword(encodePassword);

        return memberRepository.save(member);
    }

    //로그인
    @Transactional(readOnly = true)
    public MemberLoginResponseDto signInMember(MemberLoginRequestDto memberloginRequestDto) {
        Optional<Member> memberOptional = memberRepository.findByEmail(memberloginRequestDto.getEmail());
        if (memberOptional.isEmpty()) {
            throw new IllegalArgumentException("올바르지 않은 Email입니다.");
        }
        Member member = memberOptional.get();
        String encodePassword = PasswordEncoder.sha256(memberloginRequestDto.getPassword());
        if (!encodePassword.equals(member.getPassword())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        MemberLoginResponseDto memberLoginResponseDto = MemberLoginResponseDto.builder()
                .memberId(member.getMemberId())
                .email(member.getEmail())
                .nickname(member.getNickname())
                .autoDiaryTime(member.getAutoDiaryTime())
                .diaryBaseName(member.getDiaryBaseName())
                .firebaseUid(member.getFirebaseUid())
                .providerId(member.getProviderId())
                .build();

        return memberLoginResponseDto;
    }

    //유저 조회
    @Transactional(readOnly = true)
    public MemberResponseDto findMember(Long memberId){

        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 member입니다."));

        return MemberResponseDto.builder()
                .memberId(member.getMemberId())
                .email(member.getEmail())
                .nickname(member.getNickname())
                .autoDiaryTime(member.getAutoDiaryTime())
                .diaryBaseName(member.getDiaryBaseName())
                .firebaseUid(member.getFirebaseUid())
                .providerId(member.getProviderId())
                .createdAt(member.getCreatedAt())
                .updatedAt(member.getUpdatedAt())
                .build();
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
    @Transactional
    public void removeMember(long memberId) {
        memberRepository.deleteById(memberId);
    }

    /**
     * 날짜가 변경될 때 모든 회원들의 랜덤 요청 상태를 초기화한다.
     */
    @Transactional
    public void resetRandomExchange() {
        List<Member> allMemberList = memberRepository.findAll();

        for(Member member : allMemberList)
            member.setRandomExchanged(false);
    }

    @Transactional(readOnly = true)
    public boolean checkRandomChangeable(Long memberId) throws Exception {
        Member member = memberRepository.findById(memberId).orElseThrow(() -> new Exception("member does not exists."));
        return member.isRandomExchanged();
    }
}
