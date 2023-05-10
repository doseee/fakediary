package com.a101.fakediary.diary.controller;

import com.a101.fakediary.chatgptdiary.dto.result.DiaryResultDto;
import com.a101.fakediary.diary.dto.DiaryFilterDto;
import com.a101.fakediary.diary.dto.DiaryRequestDto;
import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.dto.request.DiaryInformation;
import com.a101.fakediary.diary.service.DiaryService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@ApiOperation(value = "DiaryController")
@RequestMapping("/diary")
@RequiredArgsConstructor
@Slf4j
public class DiaryController {
    private final DiaryService diaryService;

//    @ApiOperation(value = "일기 등록", notes = "keyword, places, characters, diaryImageUrl \"\"으로 넣어주시면 됩니다. subtitles는 소제목1@소제목2@소제목3 이런식으로 넣어주면 됩니다, title은 띄어쓰기 포함 10글자 이하여야만합니다.")
//    @PostMapping
//    public ResponseEntity<?> saveDiary(@RequestBody DiaryRequestDto dto) {
//        try {
//            DiaryResponseDto diaryResponseDto = diaryService.createDiary(dto);
//            return ResponseEntity.ok().body(diaryResponseDto);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
//        }
//    }

    @PostMapping("/create")
    public ResponseEntity<?> saveDiaryWithDiaryInformation(@RequestBody DiaryInformation information) {
        log.info("saveDiaryWithDiaryInformation");
        log.info("memberId = " + information.getMemberId());
        log.info("cardIdList = " + information.getCardIdList());
        log.info("genreList = " + information.getGenreList());

        try {
            Long memberId = information.getMemberId();
            List<Long> cardIdList = information.getCardIdList();
            List<String> genreList = information.getGenreList();

            log.info("memberId = " + memberId);
            log.info("cardIdList = " + cardIdList);
            log.info("genreList = " + genreList);

//            DiaryResultDto diaryResultDto = diaryService.getResultDto(cardIdList);

            DiaryResponseDto diaryResponseDto = diaryService.createDiary(memberId, cardIdList, genreList);

            return new ResponseEntity<>(diaryResponseDto, HttpStatus.OK);
        } catch(Exception e) {
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
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "일기 전체 조회")
    @GetMapping("/all/{memberId}")
    public ResponseEntity<?> allDiary(@PathVariable Long memberId) {
        try {
            List<DiaryResponseDto> diary = diaryService.allDiary(memberId);
            return new ResponseEntity<List<DiaryResponseDto>>(diary, HttpStatus.OK);
        } catch (NullPointerException e){
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "일기 필터 조회, id: 선택한 사람 id, memberId: 조회한 사람 id, genre: 장르")
    @PostMapping("/filter")
    public ResponseEntity<?> filterDiary(@RequestBody DiaryFilterDto filter) {
        try {
            List<DiaryResponseDto> diary = diaryService.filterDiary(filter);
            return new ResponseEntity<List<DiaryResponseDto>>(diary, HttpStatus.OK);
        } catch (NullPointerException e){
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "일기 삭제(status상 삭제)")
    @DeleteMapping("/{diaryId}")
        public ResponseEntity<?> deleteStatusDiary(@PathVariable Long diaryId){
            try{
                diaryService.deleteStatusDiary(diaryId);
                return new ResponseEntity<>(HttpStatus.OK);
            } catch (Exception e){
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
            }
        }

    @ApiOperation(value = "일기 삭제(DB에서 삭제. 진짜 DB에서 삭제되니 status삭제로 사용 권장)")
    @DeleteMapping("/delete/{diaryId}")
    public ResponseEntity<?> deleteDiary(@PathVariable Long diaryId) {
        try {
            diaryService.deleteDiary(diaryId);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * for developing : 모든 일기 랜덤 교환 사용 내역 초기화
     * @return
     */
    @PutMapping("/reset")
    public ResponseEntity<?> setAllDiariesRandomExchangedUnused() {
        try {
            diaryService.setAllDiariesRandomExchangedUnused();
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}