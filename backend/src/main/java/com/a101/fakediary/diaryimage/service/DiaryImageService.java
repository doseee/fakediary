package com.a101.fakediary.diaryimage.service;

import com.a101.fakediary.diary.repository.DiaryRepository;
import com.a101.fakediary.diary.service.DiaryService;
import com.a101.fakediary.diaryimage.entity.DiaryImage;
import com.a101.fakediary.diaryimage.repository.DiaryImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@RequiredArgsConstructor
@Service
public class DiaryImageService {

    private final DiaryRepository diaryRepository;

    private final DiaryImageRepository diaryImageRepository;

    @Transactional
    public void createDiaryImages(Long diaryId, List<String> diaryImageUrls, List<String> diaryImagePrompt) throws Exception {

        for(int i=0; i< diaryImageUrls.size(); i++){
            DiaryImage diaryImage = new DiaryImage();
            diaryImage.setDiary(diaryRepository.findById(diaryId).orElseThrow());
            diaryImage.setDiaryImageUrl(diaryImageUrls.get(i));
            diaryImage.setImagePrompt(diaryImagePrompt.get(i));
            diaryImageRepository.save(diaryImage);
        }
    }

    @Transactional(readOnly = true)
    public String[] readDiaryImages(Long diaryId){
        return diaryImageRepository.findByDiaryImageUrl(diaryId);
    }
}
