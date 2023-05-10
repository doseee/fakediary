package com.a101.fakediary.chatgptdiary.api;

import com.a101.fakediary.chatgptdiary.dto.message.Message;
import com.a101.fakediary.chatgptdiary.dto.request.ChatGptDiaryRequestDto;

import com.a101.fakediary.chatgptdiary.dto.response.ChatGptDiaryResponseDto;
import com.a101.fakediary.chatgptdiary.prompt.ChatGptPrompts;
import com.a101.fakediary.chatgptdiary.config.ChatGptApiConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Component
@Slf4j
public class ChatGptApi {
    private final RestTemplate restTemplate35;
    private final RestTemplate restTemplate40;
    private final String MODEL_3_5;      //  gpt-3.5-turbo
    private final String MODEL_4_0;      //  gpt-4-0314
    private final String API_URL;
    private final Integer MAX_TOKENS_3_5;
    private final Integer MAX_TOKENS_4_0;
    private final Integer N;
    private final Double TEMPERATURE;

    public ChatGptApi(@Value("${fake-diary.chat-gpt.model3-5}")String MODEL_3_5,
                      @Value("${fake-diary.chat-gpt.model4-0}")String MODEL_4_0,
                      @Value("${fake-diary.chat-gpt.base-url}")String API_URL,
                      @Value("${fake-diary.chat-gpt.max-tokens3-5}")Integer MAX_TOKENS_3_5,
                      @Value("${fake-diary.chat-gpt.max-tokens4-0}")Integer MAX_TOKENS_4_0,
                      @Value("${fake-diary.chat-gpt.n}")Integer N,
                      @Value("${fake-diary.chat-gpt.temperature}")Double TEMPERATURE) {
        this.restTemplate35 = ChatGptApiConfig.chatGpt35RestTemplate();
        this.restTemplate40 = ChatGptApiConfig.chatGpt40RestTemplate();
        this.MODEL_3_5 = MODEL_3_5;
        this.MODEL_4_0 = MODEL_4_0;
        this.API_URL = API_URL;
        this.N = N;
        this.MAX_TOKENS_3_5 = MAX_TOKENS_3_5;
        this.MAX_TOKENS_4_0 = MAX_TOKENS_4_0;
        this.TEMPERATURE = TEMPERATURE;
    }

    /**
     * 
     * @param messages : 전체 프롬프트 Message
     * @param prompt   : 이번 질의에서 추가될 프롬프트 문자열
     * @return : gpt4가 만들어준 대답 프롬프트
     */
    public List<Message> askGpt4(List<Message> messages, String prompt) throws Exception {
        if(messages.isEmpty()) {
            messages.add(new Message("system", ChatGptPrompts.generateSystemPrompt()));
        }

        messages.add(new Message("user", prompt));

        ChatGptDiaryRequestDto requestDto = ChatGptDiaryRequestDto.builder()
                .model(MODEL_4_0)
                .n(N)
                .maxTokens(MAX_TOKENS_4_0)
                .temperature(TEMPERATURE)
                .messages(messages)
                .build();

        ChatGptDiaryResponseDto responseDto = restTemplate40.postForObject(API_URL, requestDto, ChatGptDiaryResponseDto.class);

        if(responseDto == null || responseDto.getChoices() == null || responseDto.getChoices().isEmpty()) {
            log.info("no response!!!");
            throw new Exception("GPT4가 응답이 없음");
        }
        
        String answer = responseDto.getChoices().get(0).getMessage().getContent().trim();
        messages.add(new Message("assistant", answer));
        
        if(!answer.endsWith("}")) {
            messages = askGpt4(messages, ChatGptPrompts.generateUserContinuePrompt());
        }
        
        return messages;
    }

    /**
     *
     * @param messages : 전체 프롬프트 Message
     * @param prompt   : 이번 질의에서 추가될 프롬프트 문자열
     * @return : gpt3.5가 만들어준 대답 프롬프트
     */
    public List<Message> askGpt35(List<Message> messages, String prompt) throws Exception {
        log.info("askGpt(" + messages + ", " + prompt);

        if(messages.isEmpty()) {
            messages.add(new Message("system", ChatGptPrompts.generateSystemPrompt()));
        }

        messages.add(new Message("user", prompt));

        ChatGptDiaryRequestDto requestDto = ChatGptDiaryRequestDto.builder()
                .model(MODEL_3_5)
                .n(N)
                .maxTokens(MAX_TOKENS_3_5)
                .temperature(TEMPERATURE)
                .messages(messages)
                .build();

        ChatGptDiaryResponseDto responseDto = restTemplate35.postForObject(API_URL, requestDto, ChatGptDiaryResponseDto.class);

        if(responseDto == null || responseDto.getChoices() == null || responseDto.getChoices().isEmpty()) {
            log.info("no response!!!");
            throw new Exception("GPT3.5가 응답이 없음");
        }

        String answer = responseDto.getChoices().get(0).getMessage().getContent().trim();
        messages.add(new Message("assistant", answer));

        if(!answer.endsWith("}")) {
            messages = askGpt4(messages, ChatGptPrompts.generateUserContinuePrompt());
        }

        return messages;
    }
}
