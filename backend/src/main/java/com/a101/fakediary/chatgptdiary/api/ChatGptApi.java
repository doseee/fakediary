package com.a101.fakediary.chatgptdiary.api;

import com.a101.fakediary.chatgptdiary.dto.message.Message;
import com.a101.fakediary.chatgptdiary.dto.request.ChatGptDiaryRequestDto;

import com.a101.fakediary.chatgptdiary.dto.response.ChatGptDiaryResponseDto;
import com.a101.fakediary.chatgptdiary.dto.result.DiaryResultDto;
import com.a101.fakediary.chatgptdiary.prompt.ChatGptPrompts;
import com.a101.fakediary.chatgptdiary.config.OpenAIRestTemplateConfig;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Component
@Slf4j
public class ChatGptApi {
    private final RestTemplate restTemplate;
    private final String MODEL;
    private final String API_URL;
    private final Integer MAX_TOKENS;
    private final Integer N;
    private final Double TEMPERATURE;

    public ChatGptApi(@Value("${fake-diary.chat-gpt.model}")String MODEL,
                      @Value("${fake-diary.chat-gpt.base-url}")String API_URL,
                      @Value("${fake-diary.chat-gpt.max-tokens}")Integer MAX_TOKENS,
                      @Value("${fake-diary.chat-gpt.n}")Integer N,
                      @Value("${fake-diary.chat-gpt.temperature}")Double TEMPERATURE) {
        this.restTemplate = OpenAIRestTemplateConfig.openAiRestTemplate();
        this.MODEL = MODEL;
        this.API_URL = API_URL;
        this.N = N;
        this.MAX_TOKENS = MAX_TOKENS;
        this.TEMPERATURE = TEMPERATURE;
    }

    /**
     * Chat-GPT에게 카드로부터 추출한 등장인물(characters), 장소(places), 키워드(keywords)들을 이용해 프롬프트를 생성해 이야기를 받도록 함
     * @param characters : 등장인물 리스트
     * @param places : 장소 리스트
     * @param keywords : 키워드 리스트
     * @return : DiaryResultDto : ChatGPT가 만들어준 title, subtitle, summary, content와 그 대답이 나온 prompt를 묶어 반환함
     */
    public DiaryResultDto askGpt(List<String> characters, List<String> places, List<String> keywords) throws Exception {
        ChatGptDiaryRequestDto requestDto = ChatGptDiaryRequestDto.builder()
                .model(MODEL)
                .n(N)
                .maxTokens(MAX_TOKENS)
                .temperature(TEMPERATURE)
                .messages(new ArrayList<>())
                .build();

        requestDto.getMessages().add(new Message("system", ChatGptPrompts.generateSystemPrompt()));
        String prompt = ChatGptPrompts.generateUserPrompt(characters, places, keywords);
        requestDto.getMessages().add(new Message("user", prompt));

        ChatGptDiaryResponseDto responseDto = restTemplate.postForObject(API_URL, requestDto, ChatGptDiaryResponseDto.class);

        if(responseDto == null || responseDto.getChoices() == null || responseDto.getChoices().isEmpty()) {
            log.info("no response!!!");
            return null;
        }

        String diaryContent = responseDto.getChoices().get(0).getMessage().getContent();
        log.info("diaryContent = " + diaryContent);

        ObjectMapper objectMapper = new ObjectMapper();
        DiaryResultDto diaryResultDto = objectMapper.readValue(diaryContent, DiaryResultDto.class);
        diaryResultDto.setPrompt(prompt);

        log.info("resultDto = " + diaryResultDto);

        return diaryResultDto;
    }
}
