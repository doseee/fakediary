package com.a101.fakediary.stablediffusion.api;

import com.a101.fakediary.papago.api.PapagoApi;
import com.a101.fakediary.stablediffusion.dto.StableDiffusion200ResponseDto;
import com.a101.fakediary.stablediffusion.dto.StableDiffusion422ResponseDto;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.ExchangeStrategies;
import org.springframework.web.reactive.function.client.WebClient;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Component
@Slf4j
public class StableDiffusionApi {
    private final ExchangeStrategies exchangeStrategies;
    private final WebClient webClient;
    private final String S3_ACCESS_KEY;
    private final String S3_SECRET_KEY;
    private final String S3_BUCKET;
    private final String STABLE_DIFFUSION_URL;
    private final int MAX_BYTE_SIZE;
    private final PapagoApi papagoApi;
    private final AWSCredentials credentials;
    private final AmazonS3 s3client;
    private static final Logger logger = LoggerFactory.getLogger(StableDiffusionApi.class);

    public StableDiffusionApi(@Value("${cloud.aws.credentials.access-key}")String S3_ACCESS_KEY,
                              @Value("${cloud.aws.credentials.secret-key}")String S3_SECRET_KEY,
                              @Value("${cloud.aws.s3.bucket}")String S3_BUCKET,
                              @Value("${fake-diary.stable-diffusion.base-url}")String STABLE_DIFFUSION_URL,
                              @Value("${fake-diary.stable-diffusion.max-memory-size}")int MAX_BYTE_SIZE,
                              PapagoApi papagoApi) {
        this.S3_ACCESS_KEY = S3_ACCESS_KEY;
        this.S3_SECRET_KEY = S3_SECRET_KEY;
        this.S3_BUCKET = S3_BUCKET;
        this.STABLE_DIFFUSION_URL = STABLE_DIFFUSION_URL;
        this.MAX_BYTE_SIZE = MAX_BYTE_SIZE;

        this.exchangeStrategies = ExchangeStrategies.builder()
                .codecs(configurer -> configurer.defaultCodecs().maxInMemorySize(MAX_BYTE_SIZE))
                .build();

        this.webClient = WebClient.builder()
                .exchangeStrategies(exchangeStrategies)
                .build();

        this.papagoApi = papagoApi;



        this.credentials = new BasicAWSCredentials(this.S3_ACCESS_KEY, this.S3_SECRET_KEY);
        this.s3client = new AmazonS3Client(credentials);
    }

    public Map<String, Object> getStableDiffusionUrlsAndPrompt(String title, List<String> subtitles) throws Exception {
        Map<String, Object> StableDiffusionMap = new HashMap<>();
        //중요한것은 prompt, steps, sampler_index
        StableDiffusionMap.put("prompt", "");
        StableDiffusionMap.put("steps", 20);
        StableDiffusionMap.put("sampler_index", "Euler a");
        StableDiffusionMap.put("enable_hr", false);
        StableDiffusionMap.put("denoising_strength", 0);
        StableDiffusionMap.put("firstphase_width", 0);
        StableDiffusionMap.put("firstphase_height", 0);
        StableDiffusionMap.put("hr_scale", 2);
        StableDiffusionMap.put("hr_upscaler", "");
        StableDiffusionMap.put("hr_second_pass_steps", 0);
        StableDiffusionMap.put("hr_resize_x", 0);
        StableDiffusionMap.put("hr_resize_y", 0);
        StableDiffusionMap.put("styles", new ArrayList<>());
        StableDiffusionMap.put("seed", -1);
        StableDiffusionMap.put("subseed", -1);
        StableDiffusionMap.put("subseed_strength", 0);
        StableDiffusionMap.put("seed_resize_from_h", -1);
        StableDiffusionMap.put("seed_resize_from_w", -1);
        StableDiffusionMap.put("sampler_name", "");
        StableDiffusionMap.put("batch_size", 1);
        StableDiffusionMap.put("n_iter", 1);
        StableDiffusionMap.put("cfg_scale", 7);
        StableDiffusionMap.put("width", 512);
        StableDiffusionMap.put("height", 512);
        StableDiffusionMap.put("restore_faces", false);
        StableDiffusionMap.put("tiling", false);
        StableDiffusionMap.put("do_not_save_samples", false);
        StableDiffusionMap.put("do_not_save_grid", false);
        StableDiffusionMap.put("negative_prompt", "");
        StableDiffusionMap.put("eta", 0);
        StableDiffusionMap.put("s_churn", 0);
        StableDiffusionMap.put("s_tmax", 0);
        StableDiffusionMap.put("s_tmin", 0);
        StableDiffusionMap.put("s_noise", 1);
        StableDiffusionMap.put("override_settings", new HashMap<>());
        StableDiffusionMap.put("override_settings_restore_afterwards", true);
        StableDiffusionMap.put("script_args", new ArrayList<>());
        StableDiffusionMap.put("script_name", "");
        StableDiffusionMap.put("send_images", true);
        StableDiffusionMap.put("save_images", false);
        StableDiffusionMap.put("alwayson_scripts", new HashMap<>());


        //subtitles 파싱해서 리스트로 들고있기
        //리스트에 제목, subtitle을 순서대로 영어로 넣는다. 각각 썸네일, 삽화들 만들용도
        List<String> diaryImagePrompt = new ArrayList<>();
        diaryImagePrompt.add(papagoApi.translate(title));

        for(String subtitle : subtitles)
            diaryImagePrompt.add(papagoApi.translate(subtitle));

        List<String> dtoImageUrl = new ArrayList<>();   // 다이어리 이미지 url들 저장할것
        // Title, subtitle들 번역해서 프롬프트로 넣고 stablediffusion 이미지 생성
//        logger.info("diaryImagePrompt를 출력하겠습니다 : " + diaryImagePrompt);
        for(String translatePrompt : diaryImagePrompt) {
//            logger.info("translatePrompt를 출력하겠습니다 : " + translatePrompt);
            StableDiffusionMap.put("prompt", translatePrompt);

            ClientResponse response = webClient.post()
                    .uri(STABLE_DIFFUSION_URL + "/sdapi/v1/txt2img")
                    .contentType(MediaType.APPLICATION_JSON)
                    .bodyValue(StableDiffusionMap)
                    .exchange()
                    .block();

            ObjectMapper objectMapper = new ObjectMapper();
            String stableDiffusionResultUrl;
            if (response.statusCode().equals(HttpStatus.OK)) {//200응답
                String responseBody = response.bodyToMono(String.class).block();
                StableDiffusion200ResponseDto response200Dto = objectMapper.readValue(responseBody, StableDiffusion200ResponseDto.class);
                String imageData = response200Dto.getImages().get(0);
                byte[] decodedImg = Base64.getDecoder().decode(imageData.getBytes("UTF-8"));
                Path destinationFile = Paths.get("image.png");
                Files.write(destinationFile, decodedImg);

                // S3에 업로드
                String uniqueKey = UUID.randomUUID().toString();
                s3client.putObject(S3_BUCKET, uniqueKey, destinationFile.toFile());

                // 이미지 url얻고
                stableDiffusionResultUrl = s3client.getUrl(S3_BUCKET, uniqueKey).toString();

                dtoImageUrl.add(stableDiffusionResultUrl);
            } else if (response.statusCode().equals(HttpStatus.UNPROCESSABLE_ENTITY)) { //422응답
                String responseBody = response.bodyToMono(String.class).block();
                StableDiffusion422ResponseDto response422Dto = objectMapper.readValue(responseBody, StableDiffusion422ResponseDto.class);

                logger.error("StableDiffusion API returned 422: " + response422Dto);

            } else {
                logger.error("Stable Diffusion Exception이 발생하였습니다. 에러발생한 map을 출력하겠습니다.");
                for (Map.Entry<String, Object> entry : StableDiffusionMap.entrySet()) {
                    logger.error(entry.getKey() + ": " + entry.getValue());
                }
                logger.error("Stable Diffusion Exception이 발생하였습니다. 에러발생한 map을 로그출력 끝");
                throw new Exception("Stable Diffusion Exception");
            }
        }

        Map<String, Object> ImageMap = new HashMap<>();
        ImageMap.put("stableDiffusionUrl", dtoImageUrl);
        ImageMap.put("diaryImagePrompt", diaryImagePrompt);

        return ImageMap;
    }

}
