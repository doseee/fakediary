package com.a101.fakediary.deeparteffects.api;

import com.a101.fakediary.imagefile.handler.ImageFileHandler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.awt.*;
import java.io.IOException;

@Component
@RequiredArgsConstructor
@Slf4j
public class DeepArtEffectsApi {
    @Value("${fake-diary.deep-art.base-url}")
    private String BASE_URL;

    @Value("${fake-diary.deep-art.api-key}")
    private String API_KEY;

    @Value("${fake-diary.deep-art.access-key}")
    private String ACCESS_KEY;

    @Value("${fake-diary.deep-art.secret-key}")
    private String SECRET_KEY;

    public Mono<String> getDeepArtEffectsStyles() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("x-api-key", API_KEY);
        headers.set("x-api-access-key", ACCESS_KEY);
        headers.set("x-api-secret-key", SECRET_KEY);

        //  2. api를 통해 style 목록을 얻어온다.
        WebClient client = WebClient.builder()
                .baseUrl(BASE_URL)
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeaders(header -> header.addAll(headers))
                .build();

        //  GET request를 보내 style의 목록을 얻어온다.
        Mono<String> response = client.get()
                .uri("/styles")
                .retrieve()
                .bodyToMono(String.class);

        return response;
    }

//    public MultipartFile getCardImageFile(MultipartFile origImageFile) throws Exception {
//        HttpHeaders headers = new HttpHeaders();
//        headers.set("x-api-key", API_KEY);
//        headers.set("x-api-access-key", ACCESS_KEY);
//        headers.set("x-api-secret-key", SECRET_KEY);
//
//        //  1. MultipartFile에서 이미지 데이터를 읽어온다.
//        byte[] imageBytes = origImageFile.getBytes();
//
//        WebClient client = WebClient.builder()
//                .baseUrl(BASE_URL)
//                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.MULTIPART_FORM_DATA_VALUE)
//                .defaultHeaders(header -> header.addAll(headers))
//                .build();
//
//        //  이미지와 styleId를 reuqestMap에 넣어서 POST request를 보낸다.
//        MultiValueMap<String, HttpEntity<?>> requestMap = new LinkedMultiValueMap<>();
//        requestMap.add("styleId", new HttpEntity<>("c7984b32-1560-11e7-afe2-06d95fe194ed"));
//        requestMap.add("image", new HttpEntity<>(new ByteArrayResource(imageBytes)));
//
//        Mono<String> response = client.post()
//                .uri("/upload")
//                .body(BodyInserters.fromMultipartData(requestMap))
//                .retrieve()
//                .bodyToMono(String.class);
//
//        //  Mono의 subscribe 메서드를 사용해, response 값을 출력함.
//        response.subscribe(res -> {
//            System.out.println("res = " + res);
//        });
//
////        //  4. 처리 결과물을 받기 위해, 다시 새로운 WebClient를 생성
////        client = WebClient.builder()
////                .baseUrl(BASE_URL + "/result")
////                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
////                .defaultHeaders(headers::addAll)
////                .build();
////
////        //  submissionId를 정의한다.
////        final String[] submissionId = {null};
////
////        // Mono의 subscribe 메소드를 사용해, response 값에서 submissionId 값을 추출합니다.
////        response.subscribe(res -> {
////            JSONObject json = new JSONObject(res);
////            submissionId[0] = json.getString("submissionId");
////        });
////
////        //  추출한 submissionIOd 값을 사용해 GET 요청을 보내고, 처리 결과물을 Mono로 받는다.
////        response = client.get()
////                .uri(uriBuilder -> uriBuilder.queryParam("submissionId", submissionId[0]).build())
////                .retrieve()
////                .bodyToMono(String.class);
////
////        //  Mono의 subscribe 메서드를 사용해 처리 결과물을 출력한다.
////        response.subscribe(res -> {
////            System.out.println("res = " + res);
////        });
//
//        return null;
//    }

    public MultipartFile getCardImageFile(MultipartFile origImageFile) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.set("x-api-key", API_KEY);
        headers.set("x-api-access-key", ACCESS_KEY);
        headers.set("x-api-secret-key", SECRET_KEY);

        //  1. MultipartFile을 Base64로 인코딩함.
        String encoded = ImageFileHandler.encode(origImageFile);

//        log.info("encoded = " + encoded);

        WebClient client = WebClient.builder()
                .baseUrl(BASE_URL)
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeader(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeaders(header -> header.addAll(headers))
                .build();

        //  이미지와 styleId를 reuqestMap에 넣어서 POST request를 보낸다.
        MultiValueMap<String, HttpEntity<?>> requestMap = new LinkedMultiValueMap<>();
        requestMap.add("styleId", new HttpEntity<>("c7984b32-1560-11e7-afe2-06d95fe194ed"));

        MediaType[] mediaType = {MediaType.IMAGE_JPEG}; // 이미지 파일의 Content-Type을 설정합니다.
        if (origImageFile.getContentType().equals("image/png")) {
            mediaType[0] = MediaType.IMAGE_PNG;
        }
        requestMap.add("image", new HttpEntity<>(encoded, new HttpHeaders() {{
            setContentType(mediaType[0]);
        }}));

        Mono<String> response = client.post()
                .uri("/upload")
                .body(BodyInserters.fromMultipartData(requestMap))
                .retrieve()
                .bodyToMono(String.class);

        //  Mono의 subscribe 메서드를 사용해, response 값을 출력함.
        response.subscribe(res -> {
            System.out.println("res = " + res);
        });

        return null;
    }

    public MultipartFile uploadImage(MultipartFile multipartFile) throws IOException  {
        HttpHeaders headers = new HttpHeaders();
        headers.set("x-api-key", API_KEY);
        headers.set("x-api-access-key", ACCESS_KEY);
        headers.set("x-api-secret-key", SECRET_KEY);
        String imageBase64Encoded = ImageFileHandler.encode(multipartFile);

        // WebClient 생성
        WebClient webClient = WebClient.builder()
                .baseUrl(BASE_URL + "/upload")
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeaders(header -> header.addAll(headers))
                .build();

        // MultiValueMap을 사용하여 요청 바디 생성
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("styleId", "c7984b32-1560-11e7-afe2-06d95fe194ed");
        body.add("imageBase64Encoded", imageBase64Encoded);

        // POST 요청 보내기
        Mono<String> response = webClient.post()
                .body(BodyInserters.fromValue(body))
                .retrieve()
                .bodyToMono(String.class);

        System.out.println("response = " + response);
        
//        response.subscribe(res -> {
//            System.out.println("res = " + res);
//        });

        webClient = WebClient.builder()
                .baseUrl(BASE_URL + "/result")
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeaders(header -> header.addAll(headers))
                .build();

        final String[] submissionId = {null};

//        response.subscribe(res -> {
//            JSONObject json = new JSONObject(res);
//            submissionId[0] = json.getString("submissionId");
//        });

        response = webClient.get()
                .uri(uriBuilder -> uriBuilder.queryParam("submissionId", submissionId[0]).build())
                .retrieve()
                .bodyToMono(String.class);

        response.subscribe(res -> {
            System.out.println("res = " + res);
        });

        return null;
    }
}
