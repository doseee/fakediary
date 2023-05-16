package com.a101.fakediary.sounddraw.controller;

import com.a101.fakediary.sounddraw.SoundDrawCrawler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/sound-draw")
public class SoundDrawTestController {
    private final SoundDrawCrawler soundDrawCrawler;

    @PostMapping
    public ResponseEntity<?> downloadMusic(@RequestBody List<String> genreList) {
        try {
            String musicUrl = soundDrawCrawler.getMusicUrl(genreList, 123124L);
            return new ResponseEntity<>(musicUrl, HttpStatus.OK);
        } catch(Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
