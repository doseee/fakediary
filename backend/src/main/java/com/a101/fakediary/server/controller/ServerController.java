package com.a101.fakediary.server.controller;

import com.a101.fakediary.server.service.ServerService;
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
    private final ServerService serverService;

    @GetMapping
    public ResponseEntity<?> getServerPort() {

        String port = serverService.findServerPort();
        if (port != null) {
            return ResponseEntity.ok(port);
        } else
            return ResponseEntity.badRequest().body("getServerPort Failed");

    }
}
