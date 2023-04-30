package com.a101.fakediary.card.dto.response;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CardSaveResponseDto {
    private Long cardId;                    //  카드의 PK
    private Long memberId;                  //  카드 만든 사람의 PK
    private String nickName;                //  카드 만든 사람의 nickname
    private String baseName;                //  카드 만든 사람이 정한 주인공 이름
    private String basePlace;               //  카드 만든 사람이 정한 장소 이름
    private List<String> keywords;          //  카드에 넣은 키워드 모음 (0 ~ 3)
    private String cardImageUrl;            //  S3에 저장된 카드 이미지 URL
}
