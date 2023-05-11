package com.a101.fakediary.stablediffusion.dto;

import lombok.*;

import java.util.List;
import java.util.Map;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StableDiffusion200ResponseDto {
    private List<String> images;
    private Map<String, Object> parameters;
    private String info;
}
