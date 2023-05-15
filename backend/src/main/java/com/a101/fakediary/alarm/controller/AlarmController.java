package com.a101.fakediary.alarm.controller;

import com.a101.fakediary.alarm.dto.AlarmListDto;
import com.a101.fakediary.alarm.entity.Alarm;
import com.a101.fakediary.alarm.service.AlarmService;
import com.a101.fakediary.diary.dto.DiaryResponseDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Api(value = "AlarmController")
@RequestMapping("/alarm")
@RequiredArgsConstructor
public class AlarmController {

    private final AlarmService alarmService;

    @ApiOperation(value = "알림 조회")
    @GetMapping("/{memberId}")
    public ResponseEntity<?> listAlarm(@PathVariable Long memberId) {
        try {
            List<AlarmListDto> list = alarmService.listAlarm(memberId);
            return new ResponseEntity<List<AlarmListDto>>(list, HttpStatus.OK);
        } catch (NullPointerException e){
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "알림 읽기")
    @GetMapping("read/{alarmId}")
    public ResponseEntity<?> readAlarm(@PathVariable Long alarmId) {
        try {
            alarmService.readAlarm(alarmId);
            return new ResponseEntity(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
