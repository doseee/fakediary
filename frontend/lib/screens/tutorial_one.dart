import 'package:flutter/material.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/screens/home_circlemenu.dart';
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
      home: TutorialOne(),
    );
  }
}

class TutorialOne extends StatefulWidget {
  const TutorialOne({super.key});

  @override
  _TutorialOneState createState() => _TutorialOneState();
}

class _TutorialOneState extends State<TutorialOne> {
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
                  flex: 2,
                  child: Column(
                    children: [
                      Lottie.asset('assets/lottie/menu_grinstar.json',height: 80),
                      Text('오늘 기억의 조각을 만들어보세요',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 7),
                      Text('사진과 키워드를 입력해 특별한 카드를 만들어요',
                          style:
                          TextStyle(color: Colors.white70, fontSize: 17)),
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
                          child: Image.asset('assets/img/toturial_card_1.png',height:350,width: 350),
                        ),
                        Flexible(
                          flex: 1,
                          child: Image.asset('assets/img/toturial_card_2.png',height:350,width: 3520,),
                        ),
                      ],
                    )),
                Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                            width: 150,
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
                                                '다음',
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
              ],
            ),
          )),
    );
  }
}
