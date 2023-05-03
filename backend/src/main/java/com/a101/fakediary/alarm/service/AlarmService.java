package com.a101.fakediary.alarm.service;

import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.friendrequest.repository.FriendRequestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class AlarmService {

    private final FriendRequestRepository friendRequestRepository;

    public List<AlarmResponseDto> listAlarm(Long memberId) {
        return friendRequestRepository.listAlarm(memberId);
    }
}
