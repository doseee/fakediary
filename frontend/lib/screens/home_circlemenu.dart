import 'package:flutter/material.dart';
import 'package:frontend/screens/card_create.dart';
import 'package:frontend/screens/card_list.dart';
import 'package:frontend/screens/diary_create_cards.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/screens/friend_screen.dart';
import 'package:frontend/screens/modify_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radius =190;

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/img/background.png'),
              ),
            ),
            child: Transform.translate(
                offset: Offset(-150, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/gif-file/moon_real.gif'),

                          )
                          // backgroundimage AssetImage('assets/gif-file/moon.gif'),
                          ,
                          Transform(
                              transform: Matrix4.identity()
                                ..translate((radius-20) * cos(radians(-75)),
                                    (radius-20) * sin(radians(-75))),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CardCreate(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                            'assets/lottie/menu_grinstar.json',
                                            width: 40),
                                        Text(
                                          '카드 만들기',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )
                                      ]))),
                          Transform(
                              transform: Matrix4.identity()
                                ..translate(radius * cos(radians(-45)),
                                    radius * sin(radians(-45))),
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
                              ..translate(radius * cos(radians(-15)),
                                  radius  * sin(radians(-15))),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                          'assets/lottie/menu_grinstar.json',
                                          width: 40),
                                      Text(
                                        '내 카드',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      )
                                    ])),
                          ),
                          Transform(
                              transform: Matrix4.identity()
                                ..translate(radius * cos(radians(15)),
                                    radius * sin(radians(15))),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DiaryListScreen(),
                                      ),
                                    );
                                  },
                                  child: Row(
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
                                ..translate(radius * cos(radians(45)),
                                    radius * sin(radians(45))),
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
                                ..translate((radius-20) * cos(radians(75)),
                                    (radius-20) * sin(radians(75))),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    ]))));
  }
//
// class MenuBtn extends StatelessWidget {
//
// final int radians;
// final String name;
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
