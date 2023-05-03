package com.a101.fakediary.friendexchangerequest.controller;

import com.a101.fakediary.friendexchangerequest.dto.FriendExchangeManageDto;
import com.a101.fakediary.friendexchangerequest.dto.FriendExchangeRequestDto;
import com.a101.fakediary.friendexchangerequest.service.FriendExchangeRequestService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@Api(value = "FriendExchangeRequestController")
@RequestMapping("friendexchange")
@RequiredArgsConstructor
public class FriendExchangeRequestController {

    private final FriendExchangeRequestService friendExchangeRequestService;

    @ApiOperation(value = "친구 일기 교환 신청")
    @PostMapping("/request")
    public ResponseEntity<?> requestFriendExchange(@RequestBody FriendExchangeRequestDto request) {
        try {
            friendExchangeRequestService.requestFriendExchange(request);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "친구 일기 상태 변경")
    @PatchMapping("/manage")
    public ResponseEntity<?> manageFriendExchange(@RequestBody FriendExchangeManageDto manage) {
        try {
            friendExchangeRequestService.manageFriendExchange(manage);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}