package com.a101.fakediary.sounddraw;

import java.util.HashMap;
import java.util.Map;

public class SoundDrawMap {
    private final static Map<String, String> moodMap;

    static {
        moodMap = new HashMap<>();
        moodMap.put("HORROR", "Scary");
        moodMap.put("THRILL", "Suspense");
        moodMap.put("SAD", "Sad");
        moodMap.put("ROMANCE", "Romantic");
        moodMap.put("HAPPY", "Happy");
        moodMap.put("ACTION", "Busy & Frantic");
        moodMap.put("COMIC", "Funny & Weird");
        moodMap.put("WARM", "Peaceful");
        moodMap.put("COMFORTING", "Laid Back");
        moodMap.put("TOUCHING", "Hopeful");
    }

    public static String getMood(String genre) {
        return moodMap.get(genre);
    }
}
