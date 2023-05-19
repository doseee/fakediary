package com.a101.fakediary.chatgptdiary.api;

import com.a101.fakediary.chatgptdiary.dto.message.Message;
import com.a101.fakediary.chatgptdiary.dto.request.ChatGptDiaryRequestDto;

import com.a101.fakediary.chatgptdiary.dto.response.ChatGptDiaryResponseDto;
import com.a101.fakediary.chatgptdiary.prompt.ChatGptLoadingPrompts;
import com.a101.fakediary.chatgptdiary.prompt.ChatGptPrompts;
import com.a101.fakediary.chatgptdiary.config.ChatGptApiConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
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

    public ChatGptApi(@Value("${fake-diary.chat-gpt.model3-5}") String MODEL_3_5,
                      @Value("${fake-diary.chat-gpt.model4-0}") String MODEL_4_0,
                      @Value("${fake-diary.chat-gpt.base-url}") String API_URL,
                      @Value("${fake-diary.chat-gpt.max-tokens3-5}") Integer MAX_TOKENS_3_5,
                      @Value("${fake-diary.chat-gpt.max-tokens4-0}") Integer MAX_TOKENS_4_0,
                      @Value("${fake-diary.chat-gpt.n}") Integer N,
                      @Value("${fake-diary.chat-gpt.temperature}") Double TEMPERATURE) {
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
     * @param messages : 전체 프롬프트 Message
     * @param prompt   : 이번 질의에서 추가될 프롬프트 문자열
     * @return : gpt4가 만들어준 대답 프롬프트
     */
    public List<Message> askGpt41(List<Message> messages, String prompt) throws Exception {
        Instant start = Instant.now();

        if (messages.isEmpty()) {
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

        ChatGptDiaryResponseDto responseDto = null;
        int gptErrorCount = 1; //429 Too Many Request, 524 Gateway Timeout 자주 발생
        final int RETRY_MAX_COUNT = 5; //최대 재시도 횟수
        final int SLEEP_MS = 7000; //재시도 간격
        boolean retry = true;

        while (retry) {
            try {
                responseDto = restTemplate40.postForObject(API_URL, requestDto, ChatGptDiaryResponseDto.class);
                retry = false; // 에러가 발생하지않고 응답 받으면 반복 중지
                if (1 < gptErrorCount)
                    log.warn("GPT에 " + gptErrorCount + "회 재시도하여 Too many Request를 해결하고 응답을 받았습니다.");
            }
            //429외에도 다양한 에러감지후 재시도하기
//            catch (HttpClientErrorException.TooManyRequests e) { // 429 Too Many Request Catch
//                log.warn("GPT Too Many Requests. 에러가 발생하였습니다. 최대 " + RETRY_MAX_COUNT + "회까지 재시도하겠습니다. 현재 시도횟수 : " + gptErrorCount);
//                if (RETRY_MAX_COUNT < gptErrorCount) {
//                    log.error("GPT Too Many Request 에러로 " + RETRY_MAX_COUNT + "회연속 실패하였습니다.");
//                    throw new Exception(RETRY_MAX_COUNT + "회연속 GPT 요청을 보냈으나 TooManyRequests에러가 발생하였습니다.");
//                }
//                // 5초 대기후 재시도
//                Thread.sleep(SLEEP_MS);
//                retry = true;
//                gptErrorCount++;
//            }
            catch (HttpStatusCodeException e) {
                int statusCode = e.getStatusCode().value();
                if (RETRY_MAX_COUNT < gptErrorCount) {
                    log.error((RETRY_MAX_COUNT + "회연속 GPT 재시도 요청을 보냈으나 " + statusCode + " 에러가 발생하였습니다. 생성을 종료합니다."));
                    throw e;
                }
                log.warn("GPT 요청과정에서 " + statusCode + "에러가 발생하였습니다. 최대 " + RETRY_MAX_COUNT + "회까지 재시도하겠습니다. 현재 시도횟수 : " + gptErrorCount);
                Thread.sleep(SLEEP_MS);
                retry = true;
                gptErrorCount++;
            }
        } //while(retry) end

//        ChatGptDiaryResponseDto responseDto = restTemplate40.postForObject(API_URL, requestDto, ChatGptDiaryResponseDto.class);


        if (responseDto == null || responseDto.getChoices() == null || responseDto.getChoices().isEmpty()) {
            log.info("no response!!!");
            throw new Exception("GPT4가 응답이 없음");
        }

        String answer = responseDto.getChoices().get(0).getMessage().getContent().trim();
        messages.add(new Message("assistant", answer));

        if (!answer.endsWith("}")) {
            messages = askGpt41(messages, ChatGptPrompts.generateUserContinuePrompt());
        }

        Instant end = Instant.now();
        log.info("GPT4 키워드로 일기 내용 받아오는데 걸리는 소요 시간 : " + Duration.between(start, end).toMillis() + " ms");

        return messages;
    }

    public List<Message> chatGpt35LoadingMessage(String genre) throws Exception {
        String userPrompt = ChatGptLoadingPrompts.getUserPrompt(genre);
        List<Message> messages = new ArrayList<>();

        messages.add(new Message("system", ChatGptLoadingPrompts.getSystemPrompt()));
        messages.add(new Message("user", userPrompt));

        ChatGptDiaryRequestDto requestDto = ChatGptDiaryRequestDto.builder()
                .model(MODEL_3_5)
                .n(N)
                .maxTokens(MAX_TOKENS_3_5)
                .temperature(TEMPERATURE)
                .messages(messages)
                .build();

        ChatGptDiaryResponseDto responseDto = restTemplate35.postForObject(API_URL, requestDto, ChatGptDiaryResponseDto.class);

        if (responseDto == null || responseDto.getChoices() == null || responseDto.getChoices().isEmpty()) {
            log.info("no response!!!");
            throw new Exception("GPT4가 응답이 없음");
        }

        String answer = responseDto.getChoices().get(0).getMessage().getContent().trim();
        messages.add(new Message("assistant", answer));

        log.info("answer = " + answer);
        log.info("messages = " + messages);

        return messages;
    }
}
