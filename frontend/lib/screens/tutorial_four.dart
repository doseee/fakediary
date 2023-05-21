import 'package:flutter/material.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/screens/tutorial_one.dart';
import 'package:frontend/screens/tutorial_screen.dart';
import 'package:frontend/screens/tutorial_three.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:lottie/lottie.dart';

// import 'search_friend_model.dart'; // Replace this with the appropriate model file

const baseUrl =
    'https://example.com/api'; // Replace this with your API base URL

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search DiaryLoading',
      home: TutorialFour(),
    );
  }
}

class TutorialFour extends StatefulWidget {
  const TutorialFour({super.key});

  @override
  _TutorialFourState createState() => _TutorialFourState();
}

class _TutorialFourState extends State<TutorialFour> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/background_1_littledark.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: WillPopScope(
            onWillPop: () async {
              // Return false to prevent going back
              return false;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 40),
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      Lottie.asset('assets/lottie/menu_grinstar.json',
                          height: 60),
                      Text('(4/4)',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)),
                      SizedBox(height: 10),
                      Text('마이페이지에 가보세요',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      Text('기본 주인공과 일기 자동 생성 시간을 정할 수 있어요',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 15)),
                    ],
                  ),
                ),
                Flexible(
                    flex: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Image.asset('assets/img/tutorial_card_8.png',
                              height: 350, width: 350),
                        ),
                        Flexible(
                          flex: 1,
                          child: Image.asset(
                            'assets/img/tutorial_card_7.png',
                            height: 350,
                            width: 3520,
                          ),
                        ),
                      ],
                    )),
                Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 130,
                            height: 50,
                            decoration: BtnThemeGradientLine(),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const TutorialThree(),
                                            ));
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 250,
                                          height: 50,
                                          decoration: BtnThemeGradientLine(),
                                          child: Center(
                                              child: Text(
                                            '이전으로',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )),
                                        ),
                                      )),
                                ),
                              ],
                            )),
                        SizedBox(width: 30),
                        Container(
                            width: 130,
                            height: 50,
                            decoration: BtnThemeGradientLine(),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen(),
                                            ));
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 250,
                                          height: 50,
                                          decoration: BtnThemeGradientLine(),
                                          child: Center(
                                              child: Text(
                                            '시작하기',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )),
                                        ),
                                      )),
                                ),
                              ],
                            )),
                      ],
                    )),
                SizedBox(height: 40)
              ],
            ),
          )),
    );
  }
}
