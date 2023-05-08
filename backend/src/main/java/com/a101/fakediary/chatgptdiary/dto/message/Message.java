package com.a101.fakediary.chatgptdiary.dto.message;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Message {
    private String role;
    private String content;
}
