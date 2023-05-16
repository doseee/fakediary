package com.a101.fakediary.diary.repository;

import com.a101.fakediary.diary.dto.DiaryFilterDto;
import com.a101.fakediary.diary.entity.Diary;
import com.a101.fakediary.enums.EExchangeType;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;

import java.util.List;

import static com.a101.fakediary.diary.entity.QDiary.diary;
import static com.a101.fakediary.genre.entity.QGenre.genre;
import static com.a101.fakediary.exchangediary.entity.QExchangedDiary.exchangedDiary;

@Repository
public class DiaryQueryRepository {
    private final EntityManager em;
    private final JPAQueryFactory queryFactory;

    public DiaryQueryRepository(EntityManager em) {
        this.em = em;
        this.queryFactory = new JPAQueryFactory(em);
    }

    public List<Diary> searchDiaryByFilter(DiaryFilterDto filter) { //선택한 memberId, 요청한 memberId, 장르
        if (filter.getId() != filter.getMemberId()) { //교환 일기 조회할 때
            BooleanBuilder g = new BooleanBuilder();
            if (!filter.getGenre().equals(" "))
                g.and(eqGenre(filter.getGenre())).and(eqGenreId());

            BooleanBuilder i = new BooleanBuilder();
            if (filter.getId() == -1) //랜덤 교환한 유저의 일기
                i.and(eqExchange().and(eqSendDiary()).and(eqReceiveId(filter.getMemberId())));
            else if (filter.getId() == -2) //조회한 유저의 모든 일기(자신, 교환)
                i.and(eqReceiveId(filter.getMemberId())).and(eqSendDiary()).or(eqMyMemberId(filter.getMemberId()));
            else //특정 유저와 교환한 일기
                i.and(eqSenderId(filter.getId())).and(eqFriend().and(eqSendDiary()).and(eqReceiveId(filter.getMemberId())));

            if (filter.getGenre().equals(" ")) { //장르가 선택 안되었을 때
                return queryFactory
                        .select(diary).distinct()
                        .from(exchangedDiary, diary) //조인 3번 하는거 막음
                        .where(i, eqDelete())
                        .fetch();
            }
            else {
                return queryFactory
                        .select(diary).distinct()
                        .from(exchangedDiary, diary, genre)
                        .where(g, i, eqDelete())
                        .fetch();
            }
        }
        else { //내 일기 조회할 때
            return queryFactory
                    .select(diary).distinct()
                    .from(diary, genre)
                    .where(eqMyMemberId(filter.getMemberId()), eqGenreId(), eqGenre(filter.getGenre()), eqDelete())
                    .fetch();
        }
    }

    private BooleanExpression eqFriend() { //e.exchageType == 'F'
        return exchangedDiary.exchangeType.eq(EExchangeType.F);
    }

    private BooleanExpression eqDelete() {//d.isDeleted == false
        return diary.isDeleted.eq(false);
    }

    private BooleanExpression eqSendDiary() { //d.diaryId =:e.receiveDiaryId
        return diary.diaryId.eq(exchangedDiary.senderDiary.diaryId);
    }

    private BooleanExpression eqSenderId(Long id) { //e.senderId =:id
        if (id == null)
            return null;
        return exchangedDiary.sender.memberId.eq(id);
    }

    private BooleanExpression eqReceiveId(Long memberId) { //e.receiveOwnerId =:memberId
        if (memberId == null)
            return null;
        return exchangedDiary.receiver.memberId.eq(memberId);
    }

    private BooleanExpression eqExchange() { //e.exchagneType = 'R'
        return exchangedDiary.exchangeType.eq(EExchangeType.R);
    }

    private BooleanExpression eqMyMemberId(Long id) { // d.memberId =:memberId
        if (id == null)
            return null;
        return diary.member.memberId.eq(id);
    }

    private BooleanExpression eqGenreId() { //d.diaryId = g.diaryId
        return genre.id.diary.diaryId.eq(diary.diaryId);
    }

    private BooleanExpression eqGenre(String mood) { //g.genre =:genre
        if (mood.equals(" "))
            return null;
        return genre.id.genre.eq(mood);
    }
}