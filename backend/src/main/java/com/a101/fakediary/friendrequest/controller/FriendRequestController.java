package com.a101.fakediary.friendrequest.controller;

import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.alarm.service.AlarmService;
import com.a101.fakediary.friendrequest.dto.FriendManageDto;
import com.a101.fakediary.friendrequest.dto.FriendRequestDto;
import com.a101.fakediary.friendrequest.service.FriendRequestService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.checkerframework.checker.units.qual.A;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
            alarmService.sendNotificationByToken(new AlarmResponseDto(request.getSenderId(), request.getReceiverId(), "friend"));
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "친구 상태 저장")
    @PatchMapping("/manage")
    public ResponseEntity<?> manageFriend(@RequestBody FriendManageDto manage) {
        try {
            friendRequestService.manageFriend(manage);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
