package com.a101.fakediary.card.dto.response;

import com.a101.fakediary.card.entity.Card;
import com.a101.fakediary.member.entity.Member;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

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
    private LocalDateTime createdAt;        // 카드 생성 날짜

    public static CardSaveResponseDto getCardSaveResponseDto(Card card) {
        List<String> keywords = new ArrayList<>();
        Member member = card.getMember();

        StringTokenizer tokens = new StringTokenizer(card.getKeyword(), "@");
        while(tokens.hasMoreTokens())
            keywords.add(tokens.nextToken());

        return CardSaveResponseDto.builder()
                .cardId(card.getCardId())
                .memberId(member.getMemberId())
                .nickName(member.getNickname())
                .baseName(card.getBaseName())
                .basePlace(card.getBasePlace())
                .keywords(keywords)
                .createdAt(card.getCreatedAt())
                .build();
    }
}
