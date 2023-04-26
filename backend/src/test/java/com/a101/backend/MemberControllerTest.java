package com.a101.backend;

import com.a101.fakediary.member.controller.MemberController;
import com.a101.fakediary.member.dto.MemberSaveRequestDto;
import com.a101.fakediary.member.repository.MemberRepository;
import com.a101.fakediary.member.service.MemberService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

@RunWith(SpringRunner.class)
@WebMvcTest(MemberController.class)
public class MemberControllerTest {

    @Autowired
    private MockMvc mvc;

    @MockBean
    private MemberService memberService;

    @MockBean
    private MemberRepository memberRepository;

    @Test
    public void 회원가입_성공() throws Exception {
        // given
        MemberSaveRequestDto memberSaveRequestDto = new MemberSaveRequestDto();
        memberSaveRequestDto.setEmail("test@test.com");
        memberSaveRequestDto.setPassword("password");
        memberSaveRequestDto.setNickname("nickname");

        // when
        when(memberService.signUpMember(any())).thenReturn(ResponseEntity.ok().build());

        // then
        mvc.perform(post("/member/signup")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(new ObjectMapper().writeValueAsString(memberSaveRequestDto)))
                .andExpect(status().isOk());
    }

    @Test
    public void 로그인_성공() throws Exception {
        // given
        String email = "test@test.com";
        String password = "password";

        // when
        when(memberService.signInMember(anyString(), anyString())).thenReturn(ResponseEntity.ok().build());

        // then
        mvc.perform(post("/member/login")
                        .param("email", email)
                        .param("password", password))
                .andExpect(status().isOk());
    }
}