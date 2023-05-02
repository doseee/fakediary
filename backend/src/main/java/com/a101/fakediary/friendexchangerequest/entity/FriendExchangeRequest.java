package com.a101.fakediary.friendexchangerequest.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.member.entity.Member;
import lombok.*;

import javax.persistence.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class FriendExchangeRequest extends BaseEntity {
    @SequenceGenerator(
            name="FRIENDEXCHANGEREQUEST_SEQ_GEN",
            sequenceName = "FRIENDEXCHANGEREQUEST_SEQ",
            initialValue = 100,
            allocationSize = 1
    )
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FRIENDEXCHANGEREQUEST_SEQ_GEN")
    private Long friendExchangeRequestId;

    @ManyToOne
    @JoinColumn(name = "sender_id", nullable = false)
    private Member sender;              //  교환 요청을 보낸 사용자

    @ManyToOne
    @JoinColumn(name = "sender_diary_id", nullable = false)
    private Diary senderDiary;          //  교환 요청을 보낼 때 쓰인 일기

    @ManyToOne
    @JoinColumn(name = "receiver_id", nullable = false)
    private Member receiver;            //  교환 요청을 받은 사용자

    @ManyToOne
    @JoinColumn(name = "receiver_diary_id")
    private Diary receiverDiary;        //  교환 요청이 수락되었을 때 교환 요청을 받은 사용자가 제공한 일기

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ERequestStatus status;  //  친구 간 일기 교환 요청 처리 상태
}

