import 'package:flutter/material.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/screens/tutorial_four.dart';
import 'package:frontend/screens/tutorial_screen.dart';
import 'package:frontend/screens/tutorial_two.dart';
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
      home: TutorialThree(),
    );
  }
}

class TutorialThree extends StatefulWidget {
  const TutorialThree({super.key});

  @override
  _TutorialThreeState createState() => _TutorialThreeState();
}

class _TutorialThreeState extends State<TutorialThree> {
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
                  flex: 4,
                  child: Column(
                    children: [
                      Lottie.asset('assets/lottie/menu_grinstar.json',
                          height: 60),
                      Text('(3/4)',
                          style:
                          TextStyle(color: Colors.white70, fontSize: 12)),
                      SizedBox(height: 10),
                      Text('지인과 친구 맺고 일기를 교환해요',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 15),
                      Lottie.asset('assets/lottie/1-alien.json', height: 35),
                      SizedBox(height: 7),
                      Text('  외계인과의 교환은 덤이에요',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 15)),
                      SizedBox(height: 7),
                      Text('모르는 친구의 랜덤일기도 볼 수 있어요',
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
                          child: Image.asset('assets/img/card_tutorial_5.png',
                              height: 350, width: 350),
                        ),
                        Flexible(
                          flex: 1,
                          child: Image.asset(
                            'assets/img/card_tutorial_6.png',
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
                                                  const TutorialTwo(),
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
                                                  const TutorialFour(),
                                            ));
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 250,
                                          height: 50,
                                          decoration: BtnThemeGradientLine(),
                                          child: Center(
                                              child: Text(
                                            '다음으로',
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
