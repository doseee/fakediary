package com.a101.fakediary.gpt3.service;

import com.a101.fakediary.gpt3.config.GPTConfig;
import com.a101.fakediary.gpt3.dto.request.GPTRequestDto;
import com.a101.fakediary.gpt3.dto.request.QuestionRequestDto;
import com.a101.fakediary.gpt3.dto.response.GPTResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class GPTService {
    private static RestTemplate restTemplate = new RestTemplate();

    public HttpEntity<GPTRequestDto> buildHttpEntity(GPTRequestDto gptRequestDto) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType(GPTConfig.MEDIA_TYPE));
        headers.add(GPTConfig.AUTHORIZATION, GPTConfig.BEARER + GPTConfig.API_KEY);
        return new HttpEntity<>(gptRequestDto, headers);
    }

    public GPTResponseDto getResponse(HttpEntity<GPTRequestDto> gptRequestDtoHttpEntity) {
        ResponseEntity<GPTResponseDto> responseEntity = restTemplate.postForEntity(
                GPTConfig.URL,
                gptRequestDtoHttpEntity,
                GPTResponseDto.class
        );

        return responseEntity.getBody();
    }

    public GPTResponseDto askQuestion(QuestionRequestDto requestDto) {
        return this.getResponse(
                this.buildHttpEntity(
                        new GPTRequestDto(
                                GPTConfig.MODEL,
                                requestDto.getQuestion(),
                                GPTConfig.MAX_TOKEN,
                                GPTConfig.TEMPERATURE,
                                GPTConfig.TOP_P
                        )
                )
        );
    }

}
