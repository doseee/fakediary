import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/diary_list_filtered_screen.dart';

class ReceiveDiaryModal extends StatelessWidget {
  final int requestId;
  // final double? height;
  // final double padding;
  // final Widget widget;
  // final bool color;

  const ReceiveDiaryModal({
    Key? key,
    required this.requestId,
    // required this.widget,
    // this.height,
    // required this.color,
    // required this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Dialog(
        backgroundColor: Color(0xff0f2027),
        // backgroundColor ? Color(0xff0f2027) : Colors.transparent,
        child: SizedBox(
          width: 300,
          height: 160,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35,
                ),
                Text(
                  '일기 교환 요청을 수락하시겠습니까?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff263344),
                              Color(0xff1B2532).withOpacity(0.538),
                              Color(0xff1C2A3D).withOpacity(0.502),
                              Color(0xff1E2E42).withOpacity(0.46),
                              Color(0xff364B66).withOpacity(0.33),
                              Color(0xff2471D6).withOpacity(0),
                            ],
                          ),
                        ),
                        child: Center(
                            child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiaryFilteredScreen(
                              diaries: [],
                              recieverId: requestId,
                            ),
                          ),
                        );
                        Flushbar(
                          message: '교환할 일기를 선택해주세요.',
                          duration: Duration(seconds: 2),
                        ).show(context);
                      },
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 1.0],
                            colors: [
                              Color(0xff65D5A6),
                              Color(0xff1E72AC),
                            ],
                          ),
                        ),
                        child: Center(
                            child: Text(
                          '수락',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
