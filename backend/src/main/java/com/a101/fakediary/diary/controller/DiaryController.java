package com.a101.fakediary.diary.controller;

import com.a101.fakediary.diary.dto.DiaryRequestDto;
import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.service.DiaryService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@ApiOperation(value = "DiaryController")
@RequestMapping("/diary")
@RequiredArgsConstructor
public class DiaryController {

    private final DiaryService diaryService;

    @ApiOperation(value = "일기 등록")
    @PostMapping
    public ResponseEntity<?> saveDiary(@RequestBody DiaryRequestDto dto) {
        try {
            Diary diary = diaryService.createDiary(dto);
            return ResponseEntity.ok().body(diary);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @ApiOperation(value = "일기 상세 조회")
    @GetMapping("/detail/{diaryId}")
    public ResponseEntity<?> detailDiary(@PathVariable Long diaryId) {
        try {
            DiaryResponseDto diary = diaryService.detailDiary(diaryId);
            return new ResponseEntity<DiaryResponseDto>(diary, HttpStatus.OK);
        } catch (NullPointerException e){
            return new ResponseEntity(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "일기 전체 조회")
    @GetMapping("/all/{memberId}")
    public ResponseEntity<?> allDiary(@PathVariable Long memberId) {
        try {
            List<DiaryResponseDto> diary = diaryService.allDiary(memberId);
            return new ResponseEntity<List<DiaryResponseDto>>(diary, HttpStatus.OK);
        } catch (NullPointerException e){
            return new ResponseEntity(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "일기 필터 조회")
    @GetMapping("/filter/{memberId}/{genre}")
    public ResponseEntity<?> filterDiary(@PathVariable Long memberId, @PathVariable String genre) {
        try {
            List<DiaryResponseDto> diary = diaryService.filterDiary(memberId, genre);
            return new ResponseEntity<List<DiaryResponseDto>>(diary, HttpStatus.OK);
        } catch (NullPointerException e){
            return new ResponseEntity(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "일기 삭제")
    @DeleteMapping("/delete/{diaryId}")
    public ResponseEntity<?> deleteDiary(@PathVariable Long diaryId) {
        try {
            diaryService.deleteDiary(diaryId);
            return new ResponseEntity(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}