package com.a101.fakediary.alarm.service;

import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.friendrequest.repository.FriendRequestRepository;
import com.a101.fakediary.member.entity.Member;
import com.a101.fakediary.member.repository.MemberRepository;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import javax.transaction.Transactional;
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

    public List<AlarmResponseDto> listAlarm(Long memberId) {
        return friendRequestRepository.listAlarm(memberId);
    }

    public String sendNotificationByToken(AlarmResponseDto alarm) {
        Member member = memberRepository.findByMemberId(alarm.getReceiverId());
        Member friend = memberRepository.findByMemberId(alarm.getSenderId());

        String title = "", body = "";
        if (alarm.getStatus().equals("exchange")) {
            title = member.getNickname() + "님, 친구가 일기를 교환하고 싶어해요!";
            body = friend.getNickname() + "님이 교환을 신청했습니다.";
        }
        else {
            title = member.getNickname() + "님, 친구 신청이 도착했어요!";
            body = friend.getNickname() + "님이 교환을 신청했습니다.";
        }

        Map<String, String> data = new HashMap<>();
        data.put("FLUTTER_NOTIFICATION_CLICK", alarm.getStatus());
        alarm.setData(data);

        if (member != null) {
            if (member.getFirebaseUid() != null) {
                Notification notification = Notification.builder()
                        .setTitle(title)
                        .setBody(body)
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
