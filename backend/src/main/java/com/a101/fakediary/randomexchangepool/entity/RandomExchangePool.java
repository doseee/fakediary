package com.a101.fakediary.randomexchangepool.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.member.entity.Member;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class RandomExchangePool extends BaseEntity {
    @Id
    private Long randomExchangePoolId;

    @OneToOne
    private Diary diary;    //  교환할 일기

    @ManyToOne
    @JoinColumn(name = "owner_id", nullable = false) //  교환할 일기의 주인
    private Member owner;

    @Column(nullable = false)
    private LocalDate randomDate;   //  교환 신청한 날짜

    @OneToOne
    private Diary exchangedDiary;   //  교환된 일기
    
    @ManyToOne
    @JoinColumn(name = "exchanged_owner_id")
    private Member exchangedOwner;  //  교환된 일기 주인
}
