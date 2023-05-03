package com.a101.fakediary.friendrequest.entity;

import com.a101.fakediary.common.BaseEntity;
import com.a101.fakediary.enums.ERequestStatus;
import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.member.entity.Member;
import lombok.*;

import javax.persistence.*;

@SqlResultSetMapping(
        name = "AlarmResponseDtoMapping",
        classes = @ConstructorResult(
                targetClass = AlarmResponseDto.class,
                columns = {
                        @ColumnResult(name = "id", type = Long.class),
                        @ColumnResult(name = "status", type = String.class)
                }
        )
)
@NamedNativeQuery(
        name = "AlarmResponseQuery",
        query = "SELECT IF(f.receiver_id = :receiverId, f.friend_exchange_request_id, f.friend_request_id) AS id, " +
                "IF(f.receiver_id = :memberId, 'exchange', 'friend') AS status " +
                "FROM friend_exchange_request f, friend_request r " +
                "WHERE (f.receiver_id = :memberId AND f.status = 'WAITING') " +
                "OR (r.receiver_id = :memberId AND r.status = 'WAITING')",
        resultSetMapping = "AlarmResponseDtoMapping"
)

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class FriendRequest extends BaseEntity {
    @SequenceGenerator(
            name = "FRIEND_REQUEST_SEQ_GEN",
            sequenceName = "FRIEND_REQUEST_SEQ",
            initialValue = 100,
            allocationSize = 1
    )
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FRIEND_REQUEST_GEN")
    private Long friendRequestId;

    @ManyToOne
    @JoinColumn(name = "sender_id", nullable = false)
    private Member senderId;

    @ManyToOne
    @JoinColumn(name = "receiver_id", nullable = false)
    private Member receiverId;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", length = 20, nullable = false)
    private ERequestStatus status;
}
