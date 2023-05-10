package com.a101.fakediary.carddiarymapping.service;

import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.card.service.CardService;
import com.a101.fakediary.carddiarymapping.dto.ListofCardMadeDiaryResponseDto;
import com.a101.fakediary.carddiarymapping.entity.CardDiaryMapping;
import com.a101.fakediary.carddiarymapping.entity.CardDiaryMappingPK;
import com.a101.fakediary.carddiarymapping.repository.CardDiaryMappingRepository;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.diary.repository.DiaryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Transactional
@Service
@Slf4j
public class CardDiaryMappingService {

    private final CardDiaryMappingRepository cardDiaryMappingRepository;
    private final CardService cardService;
    private final CardRepository cardRepository;
    private final DiaryRepository diaryRepository;

    @Transactional
    public void createCardDiaryMappings(Long diaryId, List<Long> cardIds) throws Exception {
        Diary diary = diaryRepository.findById(diaryId).orElseThrow(() -> new Exception("일기를 찾지 못함"));

        for (int i = 0; i < cardIds.size(); i++) {
            Card card = cardRepository.findById(cardIds.get(i)).orElseThrow();

            CardDiaryMappingPK pk = new CardDiaryMappingPK();
            pk.setCard(card);
            pk.setDiary(diary);

            CardDiaryMapping mapping = new CardDiaryMapping();
            mapping.setId(pk);
            mapping.setInputOrder(i + 1); //카드 고른 순서대로 1번부터 저장

            CardDiaryMapping entity = cardDiaryMappingRepository.save(mapping);
        }
    }

    public List<ListofCardMadeDiaryResponseDto> findCardsByDiaryId(Long diaryId) {
        List<CardDiaryMapping> mappings = cardDiaryMappingRepository.findByIdDiaryDiaryId(diaryId);
        List<ListofCardMadeDiaryResponseDto> returnDto = new ArrayList<>();
        for (CardDiaryMapping mapping : mappings) {
            returnDto.add(new ListofCardMadeDiaryResponseDto(mapping.getId().getCard()));
        }
        return returnDto;
    }
}
