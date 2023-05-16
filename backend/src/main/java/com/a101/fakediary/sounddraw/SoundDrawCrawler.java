package com.a101.fakediary.sounddraw;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;
import java.util.UUID;

@Component
@Slf4j
public class SoundDrawCrawler {
    private final String CRAWLER;
    private final String SOUND_DRAW_URL;

    public SoundDrawCrawler(@Value("${fake-diary.sound-draw.crawler}")String CRAWLER,
                            @Value("${fake-diary.sound-draw.base-url}")String SOUND_DRAW_URL) {
        this.CRAWLER = CRAWLER;
        this.SOUND_DRAW_URL = SOUND_DRAW_URL;
    }
    public String getMusicUrl(List<String> genreList, Long diaryPk) {
        StringBuilder command = new StringBuilder("python3 " + CRAWLER + " \"" + SOUND_DRAW_URL + "?length=60&tempo=normal,high,low&mood=");
        String musicFileName = diaryPk + "_" + UUID.randomUUID().toString();
        for (String genre : genreList) {
            command.append(SoundDrawMap.getMood(genre));
            command.append(",");
        }
        command.delete(command.length() - 1, command.length()); //  마지막 , 제거

        command.append("\" \"").append(musicFileName).append("\"");

        log.info("command = " + command);

        try {
            log.info("1!!!!!!!!!!!!");
            Process process = Runtime.getRuntime().exec(command.toString());
            log.info("2!!!!!!!!!!!!");
            int exitCode = process.waitFor();
            log.info("3!!!!!!!!!!!!");

            if(exitCode == 0) {
                log.info("Python script executed successfully.");
                String result = readProcessOutput(process.getInputStream());

                log.info("result = " + result);
                return result;
            } else {
                log.info("Failed to execute the Python script.");
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    private String readProcessOutput(InputStream inputStream) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        StringBuilder output = new StringBuilder();

        String line = null;

        while((line = reader.readLine()) != null)
            output.append(line);

        log.info("output = " + output);

        reader.close();
        return output.toString();
    }
}
