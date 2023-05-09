package com.a101.fakediary.alarm.dto;

import lombok.*;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.NamedNativeQuery;
import javax.persistence.SqlResultSetMapping;
import java.util.Map;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AlarmResponseDto {
    private Long senderId;
    private Long receiverId;
    private String status;
    private Map<String, String> data;

    public AlarmResponseDto(Long senderId, Long receiverId, String status) {
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.status = status;
    }
}