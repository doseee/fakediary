package com.a101.fakediary.carddiarymapping.service;

import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.card.repository.CardRepository;
import com.a101.fakediary.card.service.CardService;
import com.a101.fakediary.carddiarymapping.entity.CardDiaryMapping;
import com.a101.fakediary.carddiarymapping.entity.CardDiaryMappingPK;
import com.a101.fakediary.carddiarymapping.repository.CardDiaryMappingRepository;
import com.a101.fakediary.diary.repository.DiaryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@RequiredArgsConstructor
@Transactional
@Service
public class CardDiaryMappingService {

    private final CardDiaryMappingRepository cardDiaryMappingRepository;
    private final CardService cardService;
    private final CardRepository cardRepository;
    private final DiaryRepository diaryRepository;


    public void createCardDiaryMappings(Long diaryId, List<Long> cardIds) {
        for (int i = 0; i < cardIds.size(); i++) {
            Card card = cardRepository.findById(cardIds.get(i)).orElseThrow();

            CardDiaryMappingPK pk = new CardDiaryMappingPK();
            pk.setCard(card);
            pk.setDiary(diaryRepository.findById(diaryId).orElseThrow());

            CardDiaryMapping mapping = new CardDiaryMapping();
            mapping.setId(pk);
            mapping.setInputOrder(i + 1); //카드 고른 순서대로 1번부터 저장

            cardDiaryMappingRepository.save(mapping);
        }
    }
}
