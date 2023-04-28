package com.a101.fakediary.friendship.controller;

import com.a101.fakediary.friendship.dto.FriendshipDto;
import com.a101.fakediary.friendship.dto.FriendshipResponseDto;
import com.a101.fakediary.friendship.entity.Friendship;
import com.a101.fakediary.friendship.service.FriendshipService;
import com.a101.fakediary.member.entity.Member;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Api(value = "FriendshipController")
@RequestMapping("/friendship")
@RequiredArgsConstructor
public class FriendshipController {

    private final FriendshipService friendshipService;

    @ApiOperation(value = "친구 관계 저장")
    @PostMapping("/save")
    public ResponseEntity<?> saveFriend(@RequestBody FriendshipDto dto) {
        try {
            friendshipService.saveFriend(dto); //A,B 저장
            FriendshipDto tmp = new FriendshipDto(dto.getFriendId(), dto.getMemberId());
            friendshipService.saveFriend(tmp); //B,A 저장
            return new ResponseEntity(HttpStatus.CREATED);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "친구 삭제")
    @DeleteMapping("/delete")
    public ResponseEntity<?> deleteFriend(@RequestBody FriendshipDto dto) {
        try {
            friendshipService.deleteFriend(dto);
            return new ResponseEntity(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "닉네임으로 친구 검색")
    @GetMapping("/search/{nickname}/{memberId}")
    public ResponseEntity<?> searchFriend(@PathVariable String nickname, @PathVariable Long memberId) {
        try {
            List<Member> list = friendshipService.searchFriend(nickname, memberId);
            System.out.println(list.size());
            if (list.isEmpty())
                return new ResponseEntity(HttpStatus.NO_CONTENT);
            return new ResponseEntity<List<Member>>(list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiOperation(value = "친구 목록 조회")
    @GetMapping("/list/{memberId}")
    public ResponseEntity<?> listFriend(@PathVariable Long memberId) {
        try {
            List<FriendshipResponseDto> list = friendshipService.listFriend(memberId);
            if (list.isEmpty())
                return new ResponseEntity(HttpStatus.NO_CONTENT);
            return new ResponseEntity<List<FriendshipResponseDto>>(list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
