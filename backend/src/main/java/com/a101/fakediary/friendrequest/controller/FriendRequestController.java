package com.a101.fakediary.friendrequest.controller;

import com.a101.fakediary.alarm.service.AlarmService;
import com.a101.fakediary.friendrequest.dto.FriendRequestDto;
import com.a101.fakediary.friendrequest.service.FriendRequestService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@Api(value = "FriendRequestController")
@RequestMapping("/friendrequest")
@RequiredArgsConstructor
public class FriendRequestController {

    private final FriendRequestService friendRequestService;
    private final AlarmService alarmService;

    @ApiOperation(value = "친구 신청")
    @PostMapping("/request")
    public ResponseEntity<?> requestFriend(@RequestBody FriendRequestDto request) {
        try {
            friendRequestService.requestFriend(request);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
