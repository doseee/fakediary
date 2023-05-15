import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/theme.dart';
import '../screens/friend_screen.dart';

class ChangeButton extends StatelessWidget {
  final int exchangeSituation; //1이면 내가 교환 보내는 상황 2면 답장하는 상황
  final int diaryId;
  final int? requestId;

  const ChangeButton({
    Key? key,
    required this.exchangeSituation,
    required this.diaryId,
    this.requestId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BtnThemeGradient(),
          child: Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: GestureDetector(
              onTap: () async {
                if (exchangeSituation == 1) {
                  //내가 먼저 교환 보내는 상황
                  // 친구 선택
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendScreen(
                            diaryId: diaryId,
                            exchangeSituation: exchangeSituation),
                      ));
                } else if (exchangeSituation == 2) {
                  final result =
                      await ApiService.DiaryChangeApprove(diaryId, requestId!);
                  print('result: $result');
                  if (result == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                    Flushbar(
                            message: '일기 교환이 완료되었습니다!',
                            duration: Duration(seconds: 3),
                            flushbarPosition: FlushbarPosition.TOP)
                        .show(context);
                  }
                }
                //todo; 답장으로 교환일기 보내는 상황
                print('답장');
              },
              child: SizedBox(
                width: 250,
                height: MediaQuery.of(context).size.height/18,
                child: Center(
                  child: exchangeSituation == 2
                      ? Text(
                          '답장하기',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
                      : Text(
                          '교환하기',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
