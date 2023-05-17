package com.a101.fakediary.alarm.service;

import com.a101.fakediary.alarm.dto.AlarmListDto;
import com.a101.fakediary.alarm.dto.AlarmRequestDto;
import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.alarm.entity.Alarm;
import com.a101.fakediary.alarm.repository.AlarmRepository;
import com.a101.fakediary.enums.EAlarm;
import com.a101.fakediary.friendrequest.entity.FriendRequest;
import com.a101.fakediary.friendrequest.repository.FriendRequestRepository;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
@RequiredArgsConstructor
public class AlarmService {

    private final FirebaseMessaging firebaseMessaging;
    private final FriendRequestRepository friendRequestRepository;
    private final MemberRepository memberRepository;
    private final AlarmRepository alarmRepository;

    private Alarm requestEntity(AlarmRequestDto request) {
        return Alarm.builder()
                .memberId(memberRepository.findByMemberId(request.getMemberId()))
                .requestId(request.getRequestId())
                .title(request.getTitle())
                .body(request.getBody())
                .alarmType(EAlarm.valueOf(request.getAlarmType()))
                .build();
    }

    public void saveAlarm(AlarmRequestDto request) {
        alarmRepository.save(requestEntity(request));
    }

    public List<AlarmListDto> listAlarm(Long memberId) {
        List<Alarm> alarms = alarmRepository.listAlarm(memberId);
        List<AlarmListDto> list = new ArrayList<>();

        for (Alarm alarm : alarms)
            list.add(new AlarmListDto(alarm.getAlarmId(), alarm.getRequestId(), alarm.getMemberId().getMemberId(), alarm.getTitle(), alarm.getBody(), alarm.getAlarmType().toString(), alarm.getStatus()));

        return list;
    }

    public void readAlarm(Long alarmId) {
        Alarm alarm = alarmRepository.findByAlarmId(alarmId);
        if (alarm.getAlarmType().equals("FRIEND")) return; //친구 일기 교환 요청일 때
        if (alarm.getAlarmType().equals("REQUEST")) return; //친구 신청일 때
        alarm.setStatus(1);
    }

    @Async
    @Scheduled(cron = "0 0 9 * * ?", zone = "Asia/Seoul")
    public void sendRandomAlarm() {
        List<Alarm> list = alarmRepository.randomAlarm();
        for (Alarm alarm : list) {
            sendNotificationByToken(new AlarmResponseDto(alarm.getMemberId().getMemberId(), alarm.getTitle(), alarm.getBody()));
        }
    }

    public String sendNotificationByToken(AlarmResponseDto alarm) {
        Member member = memberRepository.findByMemberId(alarm.getMemberId());
        Map<String, String> data = new HashMap<>();
        data.put("FLUTTER_NOTIFICATION_CLICK", "ALARM");
        data.put("title", alarm.getTitle());
        data.put("body", alarm.getBody());
        data.put("memberId", alarm.getMemberId().toString());
        alarm.setData(data);

        if (member != null) {
            if (member.getFirebaseUid() != null) {
                Notification notification = Notification.builder()
                        .setTitle(alarm.getTitle())
                        .setBody(alarm.getBody())
                        // .setImage(requestDto.getImage())
                        .build();

                Message message = Message.builder()
                        .setToken(member.getFirebaseUid())
                        .setNotification(notification)
                        .putAllData(alarm.getData())
                        .build();

                try {
                    firebaseMessaging.send(message);
                    System.out.println("알림을 성공적으로 전송했습니다. targetUserId=" + member.getMemberId());
                    System.out.println(member.getFirebaseUid() + " " + notification.toString());
                    return "알림을 성공적으로 전송했습니다. targetUserId=" + member.getMemberId();
                } catch (FirebaseMessagingException e) {
                    e.printStackTrace();
                    return "알림 보내기를 실패하였습니다. targetUserId=" + member.getMemberId();
                }
            } else {
                return "서버에 저장된 해당 유저의 FirebaseToken이 존재하지 않습니다. targetUserId=" + member.getMemberId();
            }

        } else {
            return "해당 유저가 존재하지 않습니다. targetUserId=" + member.getMemberId();
        }
    }
}
