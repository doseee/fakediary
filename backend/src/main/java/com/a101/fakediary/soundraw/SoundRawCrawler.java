package com.a101.fakediary.soundraw;

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
    private final String[] moodArr = {"Scary", "Suspense", "Sad", "Romantic", "Happy",
            "Busy & Frantic", "Funny & Weird", "Peaceful", "Laid Back", "Hopeful"};
    private final MusicService musicService;
    private final int MUSIC_CNT = 3;

    public SoundRawCrawler(@Value("${cloud.aws.s3.url}")String S3_URL,
                           @Value("${fake-diary.sound-raw.port}")int PORT,
                           @Value("${fake-diary.sound-raw.base-url}")String SOUND_RAW_URL,
                           @Value("${fake-diary.sound-raw.fast-api-url}")String FAST_API_URL,
                           MusicService musicService) {
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

        for(String genre : genreList)
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
        for(int i = 0; i < MUSIC_CNT; i++) {
            for(int j = 0; j < moodArr.length; j++) {
                String mood = moodArr[j];
                log.info("다운로드할 음악 mood = " + mood);

                WebClient webClient = WebClient.create();
                StringBuilder requestUrl = new StringBuilder(this.FAST_API_URL).append("/create-and-upload");

                //  ex) 2023-05-22_Scary_aesad23423523234253235 이런 식으로 저장
                String musicFileName = LocalDate.now() + "_" + UUID.randomUUID().toString();
                StringBuilder urlQuerySb = new StringBuilder(SOUND_RAW_URL)
                        .append("?length=60&tempo=normal,high,low&mood=")
                        .append(mood);

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



//    public String getMusicUrl(List<String> genreList, Long diaryPk) {
//        String ret = null;
//
//        log.info("Python call");
//        StringBuilder[] commandBuilder = new StringBuilder[4];
////        StringBuilder[] commandBuilder = new StringBuilder[2];
//        commandBuilder[0] = new StringBuilder(PYTHON);
//        commandBuilder[1] = new StringBuilder(CRAWLER);
//        commandBuilder[2] = new StringBuilder("\"").append(SOUND_RAW_URL).append("?length=60&tempo=normal,high,low&mood=");
//        for(String genre : genreList)
//            commandBuilder[2].append(SoundRawMap.getMood(genre)).append(",");
//        commandBuilder[2].delete(commandBuilder[2].length() - 1, commandBuilder[2].length()); //  마지막 , 제거
//        commandBuilder[2].append("\"");
//        commandBuilder[3] = new StringBuilder("\"").append(String.valueOf(diaryPk)).append("_").append(UUID.randomUUID().toString()).append("\"");
//
//        String[] command = new String[commandBuilder.length];
//        for(int i = 0; i < command.length; i++) {
//            command[i] = commandBuilder[i].toString();
//            log.info("command[" + i + "] = " + command[i]);
//        }
//
//        try {
//           ret = execPython(command);
//        } catch(Exception e) {
//            e.printStackTrace();
//        }
//
//        return ret;
//    }
//
//    public static String execPython(String[] command) throws Exception {
//        List<String> outputs = new ArrayList<>();
//
//        ProcessBuilder processBuilder = new ProcessBuilder(command);
//        Process process = null;
//        InputStream inputStream = null;
//        InputStreamReader inputStreamReader = null;
//        BufferedReader bufferedReader = null;
//        String line = null;
//
//        // Python 코드의 출력 확인
//        try {
//            process = processBuilder.start();
//            log.info("process = " + process);
//
//            inputStream = process.getInputStream();
//            inputStreamReader = new InputStreamReader(inputStream);
//            bufferedReader = new BufferedReader(inputStreamReader);
//
//            log.info("@@1!!!!!!!!!");
//            while ((line = bufferedReader.readLine()) != null) {
//                log.info("line = " + line);
//                outputs.add(line);
//            }
//        } catch(Exception e) {
//            e.printStackTrace();
//            log.info("@@2!!!!!!!!!");
//            while ((line = bufferedReader.readLine()) != null) {
//                log.info("error-line = " + line);
//            }
//        }
//
//        log.info("@@3!!!!!!!!!");
//        while ((line = bufferedReader.readLine()) != null) {
//            log.info("error-line = " + line);
//        }
//
//        log.info("process = " + process);
//        int exitCode = process.waitFor();
////        System.out.println("exitCode: " + exitCode);
//        log.info("exitCode = " + exitCode);
//        log.info("process = " + process);
//
//        if(exitCode == 0)
//            return outputs.get(outputs.size() - 1);
//        return null;
//    }

//    public static String execPython(String[] command) throws Exception {
//        CommandLine commandLine = CommandLine.parse(command[0]);
//        for(int i =  1; i < command.length; i++)
//            commandLine.addArgument(command[i]);
//
//        log.info("commandLine = " + commandLine.toString());
//
//        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//        PumpStreamHandler pumpStreamHandler = new PumpStreamHandler(outputStream);
//        DefaultExecutor executor = new DefaultExecutor();
//        executor.setStreamHandler(pumpStreamHandler);
//        int exitCode = executor.execute(commandLine);
//
//        log.info("exitCode = " + exitCode);
//        log.info("output = " + outputStream.toString());
//
//        return outputStream.toString();
//    }


//    public String getMusicUrl(List<String> genreList, Long diaryPk) {
//        StringBuilder command = new StringBuilder("/usr/bin/python3 " + CRAWLER + " \"" + SOUND_DRAW_URL + "?length=60&tempo=normal,high,low&mood=");
//        String musicFileName = diaryPk + "_" + UUID.randomUUID().toString();
//        for (String genre : genreList) {
//            command.append(SoundDrawMap.getMood(genre));
//            command.append(",");
//        }
//        command.delete(command.length() - 1, command.length()); //  마지막 , 제거
//
//        command.append("\" \"").append(musicFileName).append("\"");
//
//        log.info("command = " + command);
//
//        try {
//            log.info("1!!!!!!!!!!!!");
//            Process process = Runtime.getRuntime().exec(command.toString());
//            String pythonLog = readProcessOutput(process.getInputStream());
//            log.info("2!!!!!!!!!!!!");
//            int exitCode = process.waitFor();
//            log.info("3!!!!!!!!!!!!");
//
//            if(exitCode == 0) {
//                log.info("Python script executed successfully.");
//                String result = readProcessOutput(process.getInputStream());
//
//                log.info("result = " + result);
//                log.info("pythonLog-success = " + pythonLog);
//                return result;
//            } else {
//                log.info("exitCode = " + exitCode);
//                log.info("pythonLog-fail = " + pythonLog);
//                log.info("Failed to execute the Python script.");
//            }
//        } catch(Exception e) {
//            e.printStackTrace();
//        }
//
//        return null;
//    }
//
//    private String readProcessOutput(InputStream inputStream) throws IOException {
//        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
//        StringBuilder output = new StringBuilder();
//
//        String line = null;
//
//        while((line = reader.readLine()) != null)
//            output.append(line);
//
//        log.info("output = " + output);
//
//        reader.close();
//        return output.toString();
//    }
}
