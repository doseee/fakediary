package com.a101.fakediary.chatgptdiary.prompt;

import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Slf4j
public class ChatGptPrompts {
//    private final static String SYSTEM_CONTENT = "재미있는 이야기를 써줘. 답변은 중괄호를 포함한 json 형식으로 json 외에 다른 문구는 덧붙이지 말아줘. 제목은 title에, 한줄 요약은 summary에, 소제목은 subtitles에, 내용은 contents에 넣어줘. 이야기를 한 장 당 5000자 정도의 3개의 장으로 구성해서 contents를 문자열 배열로 만들어줘. 각 장의 제목이 되는 subtitles도 contents와 같이 문자열 배열로 만들어줘. trailing comma가 없게 작성해줘.";

    private final static String SYSTEM_CONTENT = "재미있는 이야기를 써줘. 답변은 중괄호를 포함한 json 형식으로 json 외에 다른 문구는 덧붙이지 말아줘. 제목은 title에, 한줄 요약은 summary에, 소제목은 subtitles에, 내용은 contents에 넣어줘. 이야기를 한 장 당 2000자 정도의 3개의 장으로 구성해서 contents를 문자열 배열로 만들어줘. 각 장의 제목이 되는 subtitles도 contents와 같이 문자열 배열로 만들어줘.";

    private final static String USER_CHARACTERS = "주인공은 ";
    private final static String USER_PLACES = "장소는 ";
    private final static String USER_KEYWORDS = "키워드는 ";
    private final static String USER_CONNECTION = "이고, ";
    private final static String USER_END = "이야.";
    private final static String USER_CONTINUE = "끊어진 부분부터 이어서 답변해줘. 비슷한 내용을 반복하지 말고 되도록 지정한 json 형식대로 답변을 빨리 마무리해줘.";

    public static String generateSystemPrompt() {
        return SYSTEM_CONTENT;
    }
    public static String generateUserPrompt(List<String> characters, List<String> places, List<String> keywords) {
        StringBuilder contents = new StringBuilder();

        //  등장인물이 존재할 경우
        if(characters != null && !characters.isEmpty()) {
            contents.append(USER_CHARACTERS);    //  "주인공은 "
            for(String character : characters) {
                contents.append(character).append(", ");    //  "주인공은 A, B, C, "
            }
            //  마지막 쉼표(,)와 띄어쓰기( ) 제거
            contents.delete(contents.length() - 2, contents.length());  //    "주인공은 A, B, C"
        }
        log.info("등장인물 프롬프트 = " + contents);

        //  장소가 존재할 경우
        if(places != null && !places.isEmpty()) {
            if(!contents.toString().equals("")) {   //  이전 내용이 존재할 경우 연결어 붙이기
                contents.append(USER_CONNECTION);    //  "주인공은 A, B, C이고, "
            }
            contents.append(USER_PLACES);    //  "주인공은 A, B, C이고, 장소는 "
            for(String place : places) {
                contents.append(place).append(", ");    //  "주인공은 A, B, C이고, 장소는 D, E, F, "
            }
            //  마지막 쉼표(,)와 띄어쓰기( ) 제거
            contents.delete(contents.length() - 2, contents.length());  //    "주인공은 A, B, C이고, 장소는 D, E, F"
        }
        log.info("장소 프롬프트 = " + contents);

        //  키워드가 존재할 경우
        if(keywords != null && !keywords.isEmpty()) {
            if(!contents.toString().equals("")) {   //  이전 내용이 존재할 경우 연결어 붙이기
                contents.append(USER_CONNECTION);    //  "주인공은 A, B, C이고, 장소는 D, E, F이고, "
            }
            contents.append(USER_KEYWORDS);    //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 "
            for(String keyword : keywords) {
                contents.append(keyword).append(", ");   //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z, "
            }
            //  마지막 쉼표(,)와 띄어쓰기( ) 제거
            contents.delete(contents.length() - 2, contents.length());  //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z"
        }
        log.info("키워드 프롬프트 = " + contents);

        contents.append(USER_END);  //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이야."

        log.info("생성된 프롬프트 = " + contents);
        return contents.toString();
    }

    public static String generateUserContinuePrompt() {
        return USER_CONTINUE;
    }
}
