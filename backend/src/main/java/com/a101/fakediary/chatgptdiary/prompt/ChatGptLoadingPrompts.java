package com.a101.fakediary.chatgptdiary.prompt;

import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.Map;

@Slf4j
public class ChatGptLoadingPrompts {
    private static final String[] SYSTEM_PROMPTS;
    private static final Map<String, Integer> genresMap;

    static {
        SYSTEM_PROMPTS = new String[10];
        genresMap = new HashMap<>();

        genresMap.put("ROMANCE", 0);
        SYSTEM_PROMPTS[0] = "Tell me a romantic story in a short sentence.";

        genresMap.put("HORROR", 1);
        SYSTEM_PROMPTS[1] = "Tell me a scary story in a short sentence.";

        genresMap.put("THRILL", 2);
        SYSTEM_PROMPTS[2] = "Tell me a thrilling story in a short sentence.";

        genresMap.put("WARM", 3);
        SYSTEM_PROMPTS[3] = "Tell me a warm story in a short sentence.";

        genresMap.put("SAD", 4);
        SYSTEM_PROMPTS[4] = "Tell me a sad story in a short sentence.";

        genresMap.put("TOUCHING", 5);
        SYSTEM_PROMPTS[5] = "Tell me a touching story in a short sentence.";

        genresMap.put("COMFORTING", 6);
        SYSTEM_PROMPTS[6] = "Tell me a comforting story in a short sentence.";

        genresMap.put("HAPPY", 7);
        SYSTEM_PROMPTS[7] = "Tell me a happy story in a short sentence.";

        genresMap.put("ACTION", 8);
        SYSTEM_PROMPTS[8] = "Tell me an action story in a short sentence.";

        genresMap.put("COMIC", 9);
        SYSTEM_PROMPTS[9] = "Tell me a comic story in a short sentence.";
    }
}
