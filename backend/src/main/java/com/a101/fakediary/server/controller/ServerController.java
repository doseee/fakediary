package com.a101.fakediary.server.controller;

import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@ApiOperation(value = "ServerController")
@RequestMapping("/server")
@RequiredArgsConstructor
@Slf4j
public class ServerController {

    private final Environment environment;

    @GetMapping
    public ResponseEntity<?> getServerPort() {
        String port = environment.getProperty("local.server.port");
        if (port != null) {
            log.info("현재 사용중인 포트는 " + port + "번 입니다.");
            return ResponseEntity.ok(port);
        } else
            return ResponseEntity.badRequest().body("getServerPort Failed");

    }
}
