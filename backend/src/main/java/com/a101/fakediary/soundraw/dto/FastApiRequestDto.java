package com.a101.fakediary.soundraw.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class FastApiRequestDto {
    private String url;
    private String filename;
}
