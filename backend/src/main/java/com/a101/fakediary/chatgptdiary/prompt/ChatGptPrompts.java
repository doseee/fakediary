package com.a101.fakediary.chatgptdiary.prompt;

import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
public class ChatGptPrompts {
//    private final static String SYSTEM_CONTENT = "재미있는 이야기를 써줘. 답변은 중괄호를 포함한 json 형식으로 json 외에 다른 문구는 덧붙이지 말아줘. 제목은 title에, 한줄 요약은 summary에, 소제목은 subtitles에, 내용은 contents에 넣어줘. 이야기를 한 장 당 5000자 정도의 3개의 장으로 구성해서 contents를 문자열 배열로 만들어줘. 각 장의 제목이 되는 subtitles도 contents와 같이 문자열 배열로 만들어줘. trailing comma가 없게 작성해줘.";
    private final static String SYSTEM_CONTENT_SUBTITLES = "등장인물, 장소, 키워드를 바탕으로 재미있는 이야기를 쓴다고 가정해보자. 이 때 이야기의 제목은 title에, 소제목은 subtitles에 넣어줘. 전체 이야기의 제목을 title에 넣어주고, 소제목을 subtitles에 넣어줘. 이야기를 한 장 당 2000자 정도의 3개의 장으로 구성할거야. 소제목은 몇 번째 장, 이런 것 없이 소제목만 써줘. 답변은 중괄호를 포함한 json 형식으로 json 외에 다른 문구는 덧붙이지 말아줘. subtitles은 문자열 배열로 만들어줘.";
    private final static String SYSTEM_CONTENT1 = "재미있는 이야기를 써줘. 답변은 중괄호를 포함한 json 형식으로 json 외에 다른 문구는 덧붙이지 말아줘. 제목은 title에, 한줄 요약은 summary에, 소제목은 subtitles에, 내용은 contents에 넣어줘. 이야기를 한 장 당 2000자 정도의 3개의 장으로 구성해서 contents를 문자열 배열로 만들어줘. 각 장의 제목이 되는 subtitles도 contents와 같이 문자열 배열로 만들어줘.";
    private final static String SYSTEM_CONTENT2 = "주어진 제목인 title과 소제목인 subtitles, 등장인물, 장소, 키워드, 장르로 재미있는 이야기를 써줘. 답변은 중괄호를 포함한 json 형식으로 json 외에 다른 문구는 덧붙이지 말아줘. 제목은 title에, 한줄 요약은 summary에, 소제목은 subtitles에, 내용은 contents에 넣어줘. 이야기를 한 장 당 2000자 정도의 3개의 장으로 구성해서 contents를 문자열 배열로 만들어줘. 이 때 각 장의 이야기가 서로 연결되어 자연스러운 하나의 이야기로 결론이 나도록 해줘. 그리고 각 장의 시작에 subtitle을 넣지는 말아줘. 각 장의 제목이 되는 subtitles도 contents와 같이 문자열 배열로 만들어줘.";
    private final static String USER_CHARACTERS = "주인공은 ";
    private final static String USER_PLACES = "장소는 ";
    private final static String USER_KEYWORDS = "키워드는 ";
    private final static String USER_CONNECTION = "이고, ";
    private final static String USER_END = "(이)야.";
    private final static String USER_GENRES = "장르는 ";
    private final static String USER_CONTINUE = "끊어진 부분부터 이어서 답변해줘. 비슷한 내용을 반복하지 말고 되도록 지정한 json 형식대로 답변을 빨리 마무리해줘.";
    private static final Map<String, String> genresMap;

    static {
        genresMap = new HashMap<>();
        genresMap.put("ROMANCE", "로맨스");
        genresMap.put("HORROR", "호러");
        genresMap.put("THRILL", "스릴");
        genresMap.put("WARM", "따뜻한");
        genresMap.put("SAD", "슬픈");
        genresMap.put("TOUCHING", "감동적인");
        genresMap.put("COMFORTING", "위로하는");
        genresMap.put("HAPPY", "행복한");
        genresMap.put("ACTION", "액션");
        genresMap.put("COMIC", "코믹");
    }

    public static String generateSystemPrompt1() {
        return SYSTEM_CONTENT1;
    }
    public static String generateSystemPrompt2() {
        return SYSTEM_CONTENT2;
    }

    public static String generateSystemPromptTileSubtitles() {
        return SYSTEM_CONTENT_SUBTITLES;
    }

    public static String generateUserPromptWithTitleSubtitles(List<String> characters, List<String> places, List<String> keywords, List<String> genres, String title, List<String> subtitles) {
        StringBuilder contents = new StringBuilder("title은 ");

        contents.append(title).append(USER_CONNECTION).append("subtitles은 ");  //  "title은 XXX이고, subtitles은 "
        for(String subtitle : subtitles)
            contents.append(subtitle).append(", "); //  "title은 XXX이고, subtitles은 A, B, C, "
        contents.delete(contents.length() - 2, contents.length());  //  "title은 XXX이고, subtitles은 A, B, C"
        contents.append(USER_END).append(" ");  //  "title은 XXX이고, subtitles은 A, B, C(이)야. "


        //  등장인물이 존재할 경우
        if(characters != null && !characters.isEmpty()) {
            contents.append(USER_CHARACTERS);    //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 "
            for(String character : characters) {
                contents.append(character).append(", ");    //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C, "
            }
            //  마지막 쉼표(,)와 띄어쓰기( ) 제거
            contents.delete(contents.length() - 2, contents.length());  //    "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C"
        }
//        log.info("등장인물 프롬프트 = " + contents);

        //  장소가 존재할 경우
        if(places != null && !places.isEmpty()) {
            if(!contents.toString().equals("")) {   //  이전 내용이 존재할 경우 연결어 붙이기
                contents.append(USER_CONNECTION);    //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, "
            }
            contents.append(USER_PLACES);    //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 "
            for(String place : places) {
                contents.append(place).append(", ");    //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F, "
            }
            //  마지막 쉼표(,)와 띄어쓰기( ) 제거
            contents.delete(contents.length() - 2, contents.length());  //    "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F"
        }
//        log.info("장소 프롬프트 = " + contents);

        //  키워드가 존재할 경우
        if(keywords != null && !keywords.isEmpty()) {
            if(!contents.toString().equals("")) {   //  이전 내용이 존재할 경우 연결어 붙이기
                contents.append(USER_CONNECTION);    //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, "
            }
            contents.append(USER_KEYWORDS);    //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 "
            for(String keyword : keywords) {
                contents.append(keyword).append(", ");   //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z, "
            }
            //  마지막 쉼표(,)와 띄어쓰기( ) 제거
            contents.delete(contents.length() - 2, contents.length());  //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z"
        }
//        log.info("키워드 프롬프트 = " + contents);

        if(!contents.toString().equals("")) //  프롬프트가 비어 있지 않을 경우
            contents.append(USER_CONNECTION);   //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, "
        contents.append(USER_GENRES);   //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, 장르는 "
        for(String genre : genres)
            contents.append(genresMap.get(genre)).append(", ");    //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, 장르는 111, 222, "
        //  마지막 쉼표(,)와 띄어쓰기( ) 제거
        contents.delete(contents.length() - 2, contents.length());  //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, 장르는 111, 222"
        contents.append(USER_END);  //  "title은 XXX이고, subtitles은 A, B, C(이)야. 주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, 장르는 111, 222.이야."

        log.info("생성된 프롬프트 = " + contents);
        return contents.toString();
    }

    public static String generateUserContinuePrompt() {
        return USER_CONTINUE;
    }

    public static String generateUserPrompt(List<String> characters, List<String> places, List<String> keywords, List<String> genres) {
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
//        log.info("등장인물 프롬프트 = " + contents);

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
//        log.info("장소 프롬프트 = " + contents);

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
//        log.info("키워드 프롬프트 = " + contents);

        if(!contents.toString().equals("")) //  프롬프트가 비어 있지 않을 경우
            contents.append(USER_CONNECTION);   //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, "
        contents.append(USER_GENRES);   //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, 장르는 "
        for(String genre : genres)
            contents.append(genresMap.get(genre)).append(", ");    //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, 장르는 111, 222, "
        //  마지막 쉼표(,)와 띄어쓰기( ) 제거
        contents.delete(contents.length() - 2, contents.length());  //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, 장르는 111, 222"
        contents.append(USER_END);  //  "주인공은 A, B, C이고, 장소는 D, E, F이고, 키워드는 X, Y, Z이고, 장르는 111, 222.이야."

        log.info("생성된 프롬프트 = " + contents);
        return contents.toString();
    }
}
