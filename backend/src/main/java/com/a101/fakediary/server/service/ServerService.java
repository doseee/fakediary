package com.a101.fakediary.server.service;

import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class ServerService {

    private final Environment environment;

    public String findServerPort() {
        String port = environment.getProperty("local.server.port");
        if (port != null)
            return port;
        else
            throw new RuntimeException("getServerPort Failed");
    }
}
