package com.a101.fakediary.imagefile.handler;

import com.amazonaws.services.s3.AmazonS3Client;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class S3ImageFileHandler {
//    //  버킷 이름 동적 할당
//    @Value("${cloud.aws.s3.bucket}")
//    private String bucket;
//
//    //  버킷 주소 동적 할당
//    @Value("${cloud.aws.s3.url}")
//    private String defaultUrl;
//
//    private final AmazonS3Client amazonS3Client;
//    private final ImageFileRepository imageFileRepository;
//
//    public List<ImageFile> parseFileInfo(List<MultipartFile> multipartFileList) throws BaseException, IOException {
//        log.info("bucket = " + bucket);
//        log.info("defaultUrl = " + defaultUrl);
//
//        //  반환할 파일 리스트
//        List<ImageFile> retImageFileList = new ArrayList<>();
//        log.info("multipartFileList = " + multipartFileList);
//
//        //  전달된 파일 리스트가 존재할 경우
//        if(!Collections.isEmpty(multipartFileList)) {
//            for(MultipartFile multipartFile : multipartFileList) {
//                //  원본 파일 이름
//                String originalFileName = multipartFile.getOriginalFilename();
//                //  파일 URL
//                String url;
//
//                try {
//                    //  파일 확장자를 찾기 위한 코드
//                    final String extension = originalFileName.substring(originalFileName.lastIndexOf('.')).toLowerCase();
//                    //  파일 이름 암호화
//                    final String saveFileName = getUuid() + extension;
//
//                    log.info("saveFileName = " + saveFileName);
//
//                    //  파일 객체 생성
//                    //  System.getProperty => 시스템 환경에 대한 정보를 얻을 수 있다. (user.dir = 현재 작업 디렉토리)
//                    File file = new File(System.getProperty("user.dir") + saveFileName);
//
//                    file.setExecutable(true);
//                    file.setReadable(true);
//                    file.setWritable(true);
//
//                    //  파일 변환
//                    multipartFile.transferTo(file);
//
//                    //  S3 파일 업로드
//                    uploadOnS3(saveFileName, file);
//
//                    //  주소 할당
//                    url = defaultUrl + saveFileName;
//
//                    ImageFile imageFile = ImageFile.builder()
//                            .origImageFileName(originalFileName)
//                            .savedFileName(saveFileName)
//                            .imageFileUri(url)
//                            .build();
//
//                    //  생성 후 리스트에 추가
//                    retImageFileList.add(imageFile);
//
//                    //  파일 삭제
//                    file.delete();
//                } catch(StringIndexOutOfBoundsException e) {
//                    url = null;
//                }
//            }
//        }   //  if-not-empty-end
//
//        return retImageFileList;
//    }
//
//    private static String getUuid() {
//        return UUID.randomUUID().toString().replaceAll("-", "");
//    }
//
//    private void uploadOnS3(final String findName, final File file) {
//        //  AWS S3 전송 객체 생성
//        final TransferManager transferManager = new TransferManager(this.amazonS3Client);
//
//        //  요청 객체 생성
//        final PutObjectRequest request = new PutObjectRequest(bucket, findName, file);
//
//        //  업로드 시도
//        final Upload upload = transferManager.upload(request);
//
//        try {
//            upload.waitForCompletion();
//        } catch(AmazonClientException amazonClientException) {
//            log.error(amazonClientException.getMessage());
//        } catch(InterruptedException e) {
//            log.error(e.getMessage());
//        }
//    }
//
//    @Transactional
//    public int deleteImageFiles(List<ImageFile> imageFileList) {
//        log.info("in S3ImageFileHandler, deleteImageFiles");
//        log.info("imageFileRepository = " + imageFileRepository);
//
//        int ret = 0;
//
//        try {
//            ret= imageFileList.size();
//
//            for(ImageFile imageFile : imageFileList) {
////                String url = imageFile.getImageFileUri();
////                log.info("imageFile url = " + url);
//                String savedFileName = imageFile.getSavedFileName();
//                log.info("s3에 저장된 파일 이름 = " + savedFileName);
//                log.info("삭제할 이미지 = " + imageFile);
//
//                imageFileRepository.delete(imageFile);
//                //  파일이 존재할 경우
//                if(amazonS3Client.doesObjectExist(bucket, savedFileName)) {
//                    log.info("imageFile url = " + savedFileName + "이 존재");
//                    amazonS3Client.deleteObject(bucket, savedFileName);
//                } else {
//                    log.info("savedFileName = " + savedFileName + "이 존재하지 않음");
//                    throw new BaseException(ErrorMessage.IMAGE_FILE_CANT_DELETE);
//                }
//            }
//        } catch (BaseException e) {
//            log.info("무언가 잘못됨.");
//            e.printStackTrace();
//        } catch (Exception e) {
//            log.info("무언가 정말 많이 많이 잘못됨.");
//            e.printStackTrace();;
//        } finally {
//            return ret;
//        }
//    }
}

