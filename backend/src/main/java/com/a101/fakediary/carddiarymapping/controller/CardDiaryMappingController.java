package com.a101.fakediary.carddiarymapping.controller;

import com.a101.fakediary.carddiarymapping.dto.ListofCardMadeDiaryResponseDto;
import com.a101.fakediary.carddiarymapping.entity.CardDiaryMappingPK;
import com.a101.fakediary.carddiarymapping.repository.CardDiaryMappingRepository;
import com.a101.fakediary.carddiarymapping.service.CardDiaryMappingService;
import com.a101.fakediary.diary.dto.DiaryResponseDto;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.diary.service.DiaryService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/cardDiaryMapping")
@RestController
public class CardDiaryMappingController {

    private final CardDiaryMappingService cardDiaryMappingService;
    private final CardDiaryMappingRepository cardDiaryMappingRepository;
    private final DiaryRepository diaryRepository;

    @ApiOperation(value = "일기를 만든 모든 카드리스트 조회")
    @GetMapping("/card/{diaryId}")
    public ResponseEntity<?> getCardList(@PathVariable Long diaryId) {
        if(diaryRepository.findById(diaryId).isEmpty()) {
            return ResponseEntity.badRequest().body("존재하지 않는 다이어리를 조회했습니다.");
        }

        try {
            List<ListofCardMadeDiaryResponseDto> returnDto = cardDiaryMappingService.findCardsByDiaryId(diaryId);
            return ResponseEntity.ok(returnDto);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
