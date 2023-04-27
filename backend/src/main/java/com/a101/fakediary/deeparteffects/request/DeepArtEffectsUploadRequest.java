package com.a101.fakediary.deeparteffects.request;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DeepArtEffectsUploadRequest {
    private String styleId;
    private String imageBase64Encoded;
}
