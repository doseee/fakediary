package com.a101.fakediary.alarm.repository;

import com.a101.fakediary.alarm.dto.AlarmListDto;
import com.a101.fakediary.alarm.dto.AlarmResponseDto;
import com.a101.fakediary.alarm.entity.Alarm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AlarmRepository extends JpaRepository<Alarm, Long> {

    Alarm findByAlarmId(Long alarmId);
    @Query("select a from Alarm a where a.requestId =:requestId and a.alarmType= 'FRIEND'")
    Alarm findFriend(Long requestId);
    @Query("select a from Alarm a where a.requestId =:requestId and a.alarmType= 'REQUEST'")
    Alarm findRequest(Long requestId);

    @Query(value = "select * " +
            "from alarm a " +
            "where a.status = 0 and a.member_id =:memberId and a.created_at between DATE_SUB(NOW(), INTERVAL 10 DAY) AND NOW() " +
            "order by created_at desc", nativeQuery = true)
    List<Alarm> listAlarm(@Param("memberId") Long memberId);
}
