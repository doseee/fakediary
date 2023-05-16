package com.a101.fakediary.chatgptdiary.prompt;

import lombok.extern.slf4j.Slf4j;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Slf4j
public class ChatGptLoadingPrompts {
    private static final String SYSTEM_PROMPT = "Tell me a story in a short sentence.";
    private static final String[] USER_PROMPTS;
    private static final Map<String, Integer> genresMap;

    static {
        USER_PROMPTS = new String[10];
        genresMap = new HashMap<>();

        genresMap.put("ROMANCE", 0);
//        USER_PROMPTS[0] = "Tell me a romantic story in a short sentence.";
        USER_PROMPTS[0] = "Genre is romance.";

        genresMap.put("HORROR", 1);
//        USER_PROMPTS[1] = "Tell me a scary story in a short sentence.";
        USER_PROMPTS[1] = "Genre is horror.";

        genresMap.put("THRILL", 2);
//        USER_PROMPTS[2] = "Tell me a thrilling story in a short sentence.";
        USER_PROMPTS[2] = "Genre is thriller.";

        genresMap.put("WARM", 3);
//        USER_PROMPTS[3] = "Tell me a warm story in a short sentence.";
        USER_PROMPTS[3] = "Genre is warming.";

        genresMap.put("SAD", 4);
//        USER_PROMPTS[4] = "Tell me a sad story in a short sentence.";
        USER_PROMPTS[4] = "Genre is sad.";

        genresMap.put("TOUCHING", 5);
//        USER_PROMPTS[5] = "Tell me a touching story in a short sentence.";
        USER_PROMPTS[5] = "Genre is touching.";

        genresMap.put("COMFORTING", 6);
//        USER_PROMPTS[6] = "Tell me a comforting story in a short sentence.";
        USER_PROMPTS[6] = "Genre is comforting.";

        genresMap.put("HAPPY", 7);
//        USER_PROMPTS[7] = "Tell me a happy story in a short sentence.";
        USER_PROMPTS[7] = "Genre is happy.";

        genresMap.put("ACTION", 8);
//        USER_PROMPTS[8] = "Tell me an action story in a short sentence.";
        USER_PROMPTS[8] = "Genre is action.";

        genresMap.put("COMIC", 9);
//        USER_PROMPTS[9] = "Tell me a comic story in a short sentence.";
        USER_PROMPTS[9] = "Genre is comedy.";

        log.info("genresMap = " + genresMap);
        log.info("SYSTEM_PROMPTS = " + Arrays.toString(USER_PROMPTS));
    }

    public static String getSystemPrompt() {
        return SYSTEM_PROMPT;
    }

    public static String getUserPrompt(String genre) {
        log.info("genre = " + genre);
        Integer idx = genresMap.get(genre);

        log.info("idx = " + idx);

        return USER_PROMPTS[idx];
    }
}
