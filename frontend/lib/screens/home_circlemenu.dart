import 'package:flutter/material.dart';
import 'package:frontend/screens/card_create.dart';
import 'package:frontend/screens/card_list.dart';
import 'package:frontend/screens/diary_create_cards.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/screens/friend_screen.dart';
import 'package:frontend/screens/modify_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/friend_modal.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';

import 'package:vector_math/vector_math_64.dart' as vector64;

import '../model/AlarmModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const radius = 190;
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/img/background.png'),
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          key: scaffoldKey,
          drawer: AlarmDrawer(),
          body: FractionallySizedBox(
              widthFactor: 1.3,
              child: Transform(
                  transform: Matrix4.translationValues(-120, 0, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 500,
                              width: 500,
                            ),
                            Image(
                              image:
                                  AssetImage('assets/gif-file/moon_real.gif'),
                            ),
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(
                                    (radius - 10) * cos(vector64.radians(-75)),
                                    (radius - 10) * sin(vector64.radians(-75))),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CardCreate(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                        'assets/lottie/menu_grinstar.json',
                                        width: 40),
                                    Text(
                                      '카드 만들기',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Transform(
                                transform: Matrix4.identity()
                                  ..translate(
                                      radius * cos(vector64.radians(-45)),
                                      radius * sin(vector64.radians(-45))),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DiaryCreateCards(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              'assets/lottie/menu_grinstar.json',
                                              width: 40),
                                          Text(
                                            '일기 쓰기',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )
                                        ]))),
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(radius * cos(vector64.radians(-15)),
                                    radius * sin(vector64.radians(-15))),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CardList(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                            'assets/lottie/menu_grinstar.json',
                                            width: 40),
                                        Text(
                                          '내 카드',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )
                                      ])),
                            ),
                            Transform(
                                transform: Matrix4.identity()
                                  ..translate(
                                      radius * cos(vector64.radians(15)),
                                      radius * sin(vector64.radians(15))),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DiaryListScreen(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              'assets/lottie/menu_grinstar.json',
                                              width: 40),
                                          Text(
                                            '일기장',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )
                                        ]))),
                            Transform(
                                transform: Matrix4.identity()
                                  ..translate(
                                      radius * cos(vector64.radians(45)),
                                      radius * sin(vector64.radians(45))),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FriendScreen(
                                            diaryId: -100,
                                            exchangeSituation: 0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              'assets/lottie/menu_grinstar.json',
                                              width: 40),
                                          Text(
                                            '친구',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )
                                        ]))),
                            Transform(
                                transform: Matrix4.identity()
                                  ..translate(
                                      (radius - 10) * cos(vector64.radians(75)),
                                      (radius - 10) *
                                          sin(vector64.radians(75))),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ModifyScreen(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                          'assets/lottie/menu_grinstar.json',
                                          width: 40),
                                      Text(
                                        '마이페이지',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ])))),
    );
  }
//
// class MenuBtn extends StatelessWidget {
//
// final int radians;
// final String name;0
// final Widget screen;
//
// const MoodSelectButton({
// super.key,
// required this.content,
// required this.setter,
// required this.activated,
// required this.dict,
// });
//
//   @override
//   Widget Build(BuildContext context)
// }
}

class AlarmDrawer extends StatefulWidget {
  const AlarmDrawer({
    super.key,
  });

  @override
  State<AlarmDrawer> createState() => _AlarmDrawerState();
}

class _AlarmDrawerState extends State<AlarmDrawer> {
  List<AlarmModel> alarmList = [];

  @override
  void initState() {
    super.initState();
    getAlarmList();
  }

  getAlarmList() async {
    alarmList = await ApiService.getAllAlarm();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '알림',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.close)
                  ],
                ),
              ),
            ),
          ),
          // FutureBuilder(
          //   future: alarmList,
          //   builder: (context, snapshot) {
          //     return Container(

          //     );
          //   },
          // ),
          if (alarmList.isNotEmpty)
            for (AlarmModel alarm in alarmList)
              Notification(alarm: alarm, getAlarmList: getAlarmList)
          else
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '알림이 없습니다.',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Notification extends StatelessWidget {
  const Notification({
    super.key,
    required this.alarm,
    required this.getAlarmList,
  });
  final AlarmModel alarm;
  final Function getAlarmList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (alarm.alarmType == 'REQUEST') {
          showDialog(
              context: context,
              builder: (context) {
                return FriendModal(
                  friendRequestId: alarm.requestId,
                  getAlarmList: getAlarmList,
                );
              });
        } else if (alarm.alarmType == 'AUTOMATIC') {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => FriendScreen(
          //       diaryId: alarm.diaryId,
          //       exchangeSituation: 0,
          //     ),
          //   ),
          // );
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                alarm.title,
                style: TextStyle(fontSize: 15),
              ),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
