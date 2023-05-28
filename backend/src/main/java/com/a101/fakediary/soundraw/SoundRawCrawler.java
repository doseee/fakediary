package com.a101.fakediary.soundraw;

import com.a101.fakediary.mattermost.MatterMostSender;
import com.a101.fakediary.music.dto.MusicResponseDto;
import com.a101.fakediary.music.service.MusicService;
import com.a101.fakediary.soundraw.dto.FastApiRequestDto;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.PumpStreamHandler;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.io.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Component
@Slf4j
public class SoundRawCrawler {
    private final String S3_URL;
    private final String FAST_API_URL;
    private final int PORT;
    private final String SOUND_RAW_URL;
    private final String[] moodArr = {"Scary", "Suspense", "Sad", "Romantic", "Happy", "Peaceful", "Laid Back", "Hopeful", "Busy & Frantic", "Funny & Weird"};
    private final MusicService musicService;
    private final int MUSIC_CNT = 2;

    public SoundRawCrawler(@Value("${cloud.aws.s3.url}") String S3_URL,
                           @Value("${fake-diary.sound-raw.port}") int PORT,
                           @Value("${fake-diary.sound-raw.base-url}") String SOUND_RAW_URL,
                           @Value("${fake-diary.sound-raw.fast-api-url}") String FAST_API_URL,
                           MusicService musicService
                           ) {
        this.S3_URL = S3_URL;
        this.FAST_API_URL = FAST_API_URL;
        this.PORT = PORT;
        this.SOUND_RAW_URL = SOUND_RAW_URL;
        this.musicService = musicService;

        log.info("S3_URL = " + this.S3_URL);
        log.info("SOUND_RAW_URL = " + this.SOUND_RAW_URL);
        log.info("FAST_API_URL = " + FAST_API_URL);
    }

    public String getMusicUrl(List<String> genreList, Long diaryPk) {
        WebClient webClient = WebClient.create();
        StringBuilder requestUrl = new StringBuilder(this.FAST_API_URL).append("/create-and-upload");
        String musicFileName = diaryPk + "_" + UUID.randomUUID().toString();
        StringBuilder urlQuerySb = new StringBuilder(SOUND_RAW_URL)
                .append("?length=60&tempo=normal,high,low&mood=");

        for (String genre : genreList)
            urlQuerySb.append(SoundRawMap.getMood(genre)).append(",");
        urlQuerySb.delete(urlQuerySb.length() - 1, urlQuerySb.length());   //  마지막 , 제거

        log.info("requestUrl = " + requestUrl);
        log.info("musicFileName = " + musicFileName);
        log.info("urlQuerySb = " + urlQuerySb);

        FastApiRequestDto requestDto = FastApiRequestDto.builder()
                .url(urlQuerySb.toString())
                .filename(musicFileName)
                .build();

        log.info("requestDto = " + requestDto);

        Mono<String> response = webClient.post()
                .uri(requestUrl.toString())
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .body(BodyInserters.fromValue(requestDto))
                .retrieve()
                .bodyToMono(String.class);

        String responseBody = response.block();

        return (this.S3_URL + musicFileName + ".wav");
    }

    public void downloadMusicsBatch() {
        for(int iter = 0; iter < MUSIC_CNT; iter++) {
            for (int i = 0; i < moodArr.length; i++) {
                String mood = moodArr[i];
                String urlMood = mood;

                if(urlMood.equals("Busy & Frantic"))
                    urlMood = "Busy%20%26%20Frantic";
                else if(urlMood.equals("Funny & Weird"))
                    urlMood = "Funny%20%26%20Weird";

                log.info("다운로드할 음악 mood = " + mood);

                WebClient webClient = WebClient.create();
                StringBuilder requestUrl = new StringBuilder(this.FAST_API_URL).append("/create-and-upload");

                //  ex) 2023-05-22_Scary_aesad23423523234253235 이런 식으로 저장
                String musicFileName = LocalDate.now() + "_" + UUID.randomUUID().toString();
                StringBuilder urlQuerySb = new StringBuilder(SOUND_RAW_URL)
                        .append("?length=60&tempo=normal,high,low&mood=")
                        .append(urlMood);

                log.info("requestUrl = " + requestUrl);
                log.info("musicFileName = " + musicFileName);
                log.info("urlQuery = " + urlQuerySb);

                FastApiRequestDto requestDto = FastApiRequestDto.builder()
                        .url(urlQuerySb.toString())
                        .filename(musicFileName)
                        .build();

                Mono<String> response = webClient.post()
                        .uri(requestUrl.toString())
                        .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                        .body(BodyInserters.fromValue(requestDto))
                        .retrieve()
                        .bodyToMono(String.class);
                String responseBody = response.block();

                log.info("responseBody = " + responseBody);

                MusicResponseDto dto = musicService.saveMusic(musicFileName, this.S3_URL + musicFileName + ".wav", mood);
                log.info("저장된 음악 = " + dto);
            }
        }
    }
}
