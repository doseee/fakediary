package com.a101.fakediary.friendship.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.friendship.dto.FriendshipResponseDto;
import com.a101.fakediary.member.entity.Member;
import lombok.*;

import javax.persistence.*;

@SqlResultSetMapping(
        name = "FriendshipMapping",
        classes = @ConstructorResult(
                targetClass = FriendshipResponseDto.class,
                columns = {
                        @ColumnResult(name = "member_id", type = Long.class),
                        @ColumnResult(name = "friend_id", type = Long.class),
                        @ColumnResult(name = "nickname", type = String.class),
                        @ColumnResult(name = "exchange_cnt", type = Short.class)
                }
        )
)

























@NamedNativeQuery(name="listFriendQuery", query = "SELECT f.member_id AS member_id, f.friend_id AS friend_id, m.nickname AS nickname, f.exchange_cnt AS exchange_cnt " +
        "FROM Friendship f " +
        "JOIN (SELECT m.member_id AS member_id, m.nickname AS nickname " +
        "FROM Member m " +
        "JOIN Friendship f ON f.friend_id = m.member_id " +
        "WHERE f.member_id = :memberId) m " +
        "ON f.friend_id = m.member_id " +
        "WHERE f.member_id = :memberId " +
        "ORDER BY f.exchange_cnt DESC", resultSetMapping = "FriendshipMapping")
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
