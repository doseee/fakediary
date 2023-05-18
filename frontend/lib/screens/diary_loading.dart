import 'package:flutter/material.dart';
import 'package:frontend/screens/diary_create_cards.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/screens/home_circlemenu.dart';
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
      home: DiaryLoading(),
    );
  }
}

class DiaryLoading extends StatefulWidget {
  const DiaryLoading({super.key});

  @override
  _DiaryLoadingState createState() => _DiaryLoadingState();
}

class _DiaryLoadingState extends State<DiaryLoading> {
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
                SizedBox(height: 90),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('나만의 가짜 일기가 제작에 들어갔습니다',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 7),
                      Text('약 3~4분의 시간이 소요됩니다',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 15)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Lottie.asset('assets/lottie/star-twinkle.json',
                              height: 150),
                        ),
                        Flexible(
                          flex: 2,
                          child: Lottie.asset('assets/lottie/diary_write.json',
                              height: 300),
                        ),
                        Flexible(
                          flex: 1,
                          child: Lottie.asset('assets/lottie/star-twinkle.json',
                              height: 150),
                        )
                      ],
                    )),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/alarm_moon.json',
                          width: 40, height: 40),
                      Text('한땀한땀 정성스럽게 쓰는중',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w700)),
                      Lottie.asset('assets/lottie/alarm_moon.json',
                          width: 40, height: 40)
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        Container(
                            width: 250,
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
                                            '메인화면으로 가기',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )),
                                        ),
                                      )),
                                ),
                              ],
                            )),
                        SizedBox(height: 10),
                        Container(
                            width: 250,
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
                                                  const DiaryListScreen(),
                                            ));
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 250,
                                          height: 50,
                                          decoration: BtnThemeGradientLine(),
                                          child: Center(
                                              child: Text(
                                            '내 일기장 보러가기',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )),
                                        ),
                                      )),
                                ),
                              ],
                            )),
                        SizedBox(height: 10),
                        Container(
                            width: 250,
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
                                                  const DiaryCreateCards(),
                                            ));
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 250,
                                          height: 50,
                                          decoration: BtnThemeGradientLine(),
                                          child: Center(
                                              child: Text(
                                            '가짜일기 또 만들기',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )),
                                        ),
                                      )),
                                ),
                              ],
                            ))
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
