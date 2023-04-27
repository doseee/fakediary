package com.a101.fakediary.imagefile.handler;

import com.amazonaws.AmazonClientException;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.transfer.TransferManager;
import com.amazonaws.services.s3.transfer.Upload;
import lombok.RequiredArgsConstructor;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.UUID;

@Slf4j
@Component
@RequiredArgsConstructor
public class ImageFileHandler {
    //  버킷 이름 동적 할당
    @Value("${cloud.aws.s3.bucket}")
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

        log.info("originalFileName = " + originalFileName);

        try {
            int idx = originalFileName.lastIndexOf(".");
            final String extension = idx != -1 ? originalFileName.substring(idx).toLowerCase() : ".jpg";
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

    public static String encode(MultipartFile multipartFile) throws IOException {
        byte[] bytes = multipartFile.getBytes();
        byte[] encoded = Base64.encodeBase64(bytes);
        return new String(encoded);
    }

    public static MultipartFile downloadImage(String imageUrl) throws IOException {
        log.info("imageUrl = " + imageUrl);

        URL url = new URL(imageUrl);
        URLConnection connection = url.openConnection();
        InputStream inputStream = connection.getInputStream();
        byte[] bytes = IOUtils.toByteArray(inputStream);
        return new ByteArrayMultipartFile("imageFile", bytes);
    }
}

