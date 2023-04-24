package com.a101.fakediary.friendship.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.member.entity.Member;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.io.Serializable;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@IdClass(FriendshipId.class)
@Entity
public class Friendship extends BaseEntity {

    @Id
    @Column(name = "member_id")
    private Long memberId;

    @Id
    @Column(name = "friend_id")
    private Long friendId;

    @ManyToOne
    @JoinColumn(name = "member_id", insertable = false, updatable = false)
    private Member member;

    @Column(name = "exchange_cnt", nullable = false, columnDefinition = "SMALLINT default 0") // SMALLINT 대응 short
    private short exchangeCnt;

}