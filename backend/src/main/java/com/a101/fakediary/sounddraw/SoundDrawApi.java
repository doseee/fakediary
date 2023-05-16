package com.a101.fakediary.sounddraw;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class SoundDrawApi {
    public static void musicDownload(Map<String, String> input) {

    }

    private static String getChromePreferences() {
        return "{\n" +
                "  \"download\": {\n" +
                "    \"default_directory\": \"/home/ubuntu/macro/tmp\",\n" +
                "    \"prompt_for_download\": false,\n" +
                "    \"directory_upgrade\": true\n" +
                "  },\n" +
                "  \"plugins\": {\n" +
                "    \"always_open_pdf_externally\": true\n" +
                "  }\n" +
                "}";
    }
}
