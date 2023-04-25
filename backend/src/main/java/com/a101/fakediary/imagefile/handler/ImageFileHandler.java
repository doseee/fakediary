package com.a101.fakediary.imagefile.handler;

import com.amazonaws.AmazonClientException;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.transfer.TransferManager;
import com.amazonaws.services.s3.transfer.Upload;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Slf4j
@Component
@RequiredArgsConstructor
public class ImageFileHandler {
    //  버킷 이름 동적 할당
    @Value("${cloud.aws.s3.api-key}")
    private String bucket;

    //  버킷 주소 동적 할당
    @Value("${cloud.aws.s3.url}")
    private String defaultUrl;

    private final AmazonS3Client amazonS3Client;

    private static String getUuid() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    /**
     * 파일 이름과 File 객체를 받아서 S3에 저장한다.
     *
     * @param findName
     * @param file
     */
    private void uploadOnS3(final String findName, final File file) {
        //  AWS S3 전송 객체 생성
        final TransferManager transferManager = new TransferManager(this.amazonS3Client);

        //  요청 객체 생성
        final PutObjectRequest request = new PutObjectRequest(bucket, findName, file);

        //  업로드 시도
        final Upload upload = transferManager.upload(request);

        try {
            upload.waitForCompletion();
        } catch(AmazonClientException amazonClientException) {
            log.error(amazonClientException.getMessage());
        } catch(InterruptedException e) {
            log.error(e.getMessage());
        }
    }

    /**
     * MultipartFile 타입 이미지 파일을 입력받아서 S3에 저장할 수 있도록 File로 변경
     * S3에 저장될 URL을 반환한다.
     *
     * @param multipartFile
     * @return
     * @throws IOException
     */
    public String uploadOnS3(final MultipartFile multipartFile) throws IOException {
        if (multipartFile == null)
            return null;

        String originalFileName = multipartFile.getOriginalFilename();
        String url = null;

        try {
            final String extension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();
            //  파일 이름 암호화
            final String saveFileName = getUuid() + extension;

            //  파일 객체 생성
            File file = new File(System.getProperty("user.dir") + saveFileName);

            file.setExecutable(true);
            file.setReadable(true);
            file.setWritable(true);

            multipartFile.transferTo(file);

            uploadOnS3(saveFileName, file);
            url = defaultUrl + saveFileName;

            file.delete();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return url;
    }

    /**
     * DeepArtEffects에 보내기 위해 MultipartFile을 File로 변환함
     *
     * @param multipartFile
     * @return
     */
    public File convertMultipartFileToFile(MultipartFile multipartFile) {
        if(multipartFile == null)
            return null;

        String originalFileName = multipartFile.getOriginalFilename();
        File file = null;

        try {
            //  파일 객체 생성
            file = new File(System.getProperty("user.dir") + originalFileName);

            file.setExecutable(true);
            file.setReadable(true);
            file.setWritable(true);

            multipartFile.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return file;
    }
}

