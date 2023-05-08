package com.a101.fakediary.gpt3.service;

import com.a101.fakediary.gpt3.config.GPTConfig;
import com.a101.fakediary.gpt3.dto.request.GPT3RequestDto;
import com.a101.fakediary.gpt3.dto.request.QuestionRequestDto;
import com.a101.fakediary.gpt3.dto.response.GPT3ResponseDto;
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
public class GPT3Service {
    private static RestTemplate restTemplate = new RestTemplate();

    public HttpEntity<GPT3RequestDto> buildHttpEntity(GPT3RequestDto gpt3RequestDto) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType(GPTConfig.MEDIA_TYPE));
        headers.add(GPTConfig.AUTHORIZATION, GPTConfig.BEARER + GPTConfig.API_KEY);
        return new HttpEntity<>(gpt3RequestDto, headers);
    }

    public GPT3ResponseDto getResponse(HttpEntity<GPT3RequestDto> gptRequestDtoHttpEntity) {
        ResponseEntity<GPT3ResponseDto> responseEntity = restTemplate.postForEntity(
                GPTConfig.URL,
                gptRequestDtoHttpEntity,
                GPT3ResponseDto.class
        );

        return responseEntity.getBody();
    }

    public GPT3ResponseDto askQuestion(QuestionRequestDto requestDto) {
        return this.getResponse(
                this.buildHttpEntity(
                        new GPT3RequestDto(
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
