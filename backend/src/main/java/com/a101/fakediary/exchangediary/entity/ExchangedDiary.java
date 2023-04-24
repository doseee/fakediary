package com.a101.fakediary.exchangediary.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.enums.ExchangeType;
import com.a101.fakediary.member.entity.Member;
import lombok.*;

import javax.persistence.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class ExchangedDiary extends BaseEntity {
    @Id
    private Long exchangedDiaryId;

    @ManyToOne
    @JoinColumn(name = "sender_id", nullable = false)
    private Member sender;              //  보낸 일기 작성자

    @ManyToOne
    @JoinColumn(name = "send_diary_id", nullable = false)
    private Diary senderDiary;            //  보낸 일기

    @ManyToOne
    @JoinColumn(name = "receive_owner_id", nullable = false)
    private Member receiver;              //  받은 일기 작성자

    @ManyToOne
    @JoinColumn(name = "receive_diary_id", nullable = false)
    private Diary receiverDiary;            //  받은 일기

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ExchangeType exchangeType;  //  교환 유형


}
