import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/theme.dart';
import '../screens/friend_screen.dart';
import '../screens/old_home_screen.dart';


class ChangeButton extends StatelessWidget {
  final int exchangeSituation; //1이면 내가 교환 보내는 상황 2면 답장하는 상황
  final int diaryId;

  const ChangeButton({Key? key, required this.exchangeSituation, required this.diaryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(flex: 3, child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BtnThemeGradient(),
        child: Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: GestureDetector(
              onTap: () {
                if(exchangeSituation == 1) { //내가 먼저 교환 보내는 상황
                  // 친구 선택
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendScreen(diaryId: diaryId, exchangeSituation: exchangeSituation),
                      ));
                }
                //todo; 답장으로 교환일기 보내는 상황
                print('답장');
              },
              child: Container(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text(
                    '교환하기',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              )),
        ),
      ),
    ),);
  }
}
