package com.a101.fakediary.soundraw;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.*;
import java.util.List;
import java.util.UUID;

@Component
@Slf4j
public class SoundRawCrawler {
    private final String PYTHON;
    private final String CRAWLER;
    private final String SOUND_RAW_URL;

    public SoundRawCrawler(@Value("${fake-diary.sound-raw.python}")String PYTHON,
                           @Value("${fake-diary.sound-raw.crawler}")String CRAWLER,
                           @Value("${fake-diary.sound-raw.base-url}")String SOUND_RAW_URL) {
        this.PYTHON = PYTHON;
        this.CRAWLER = CRAWLER;
        this.SOUND_RAW_URL = SOUND_RAW_URL;
    }

    public String getMusicUrl(List<String> genreList, Long diaryPk) {
        log.info("Python call");
//        StringBuilder[] commandBuilder = new StringBuilder[4];
        StringBuilder[] commandBuilder = new StringBuilder[2];
        commandBuilder[0] = new StringBuilder(PYTHON);
        commandBuilder[1] = new StringBuilder(CRAWLER);
//        commandBuilder[2] = new StringBuilder("\"").append(SOUND_RAW_URL).append("?length=60&tempo=normal,high,low&mood=");
//        for(String genre : genreList)
//            commandBuilder[2].append(SoundRawMap.getMood(genre)).append(",");
//        commandBuilder[2].delete(commandBuilder[2].length() - 1, commandBuilder[2].length()); //  마지막 , 제거
//        commandBuilder[2].append("\"");
//        commandBuilder[3] = new StringBuilder("\"").append(String.valueOf(diaryPk)).append("_").append(UUID.randomUUID().toString()).append("\"");

        String[] command = new String[commandBuilder.length];
        for(int i = 0; i < command.length; i++) {
            command[i] = commandBuilder[i].toString();
            log.info("command[" + i + "] = " + command[i]);
        }

        try {
            execPython(command);
        } catch(Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public static void execPython(String[] command) throws Exception {
        ProcessBuilder processBuilder = new ProcessBuilder(command);
        Process process = processBuilder.start();

        // Python 코드의 출력 확인
        try (InputStream inputStream = process.getInputStream();
             InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
             BufferedReader bufferedReader = new BufferedReader(inputStreamReader)) {
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                log.info("line = " + line);
            }
        } catch(Exception e) {
            InputStream inputStream = process.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            e.printStackTrace();

            String line;
            while ((line = bufferedReader.readLine()) != null) {
                log.info("error-line = " + line);
            }
        }

        int exitCode = process.waitFor();
//        System.out.println("exitCode: " + exitCode);
        log.info("exitCode = " + exitCode);
    }


//    public static void execPython(String[] command) throws Exception {
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
