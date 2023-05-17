import 'package:flutter/material.dart';
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
      home: SendLoading(),
    );
  }
}

class SendLoading extends StatefulWidget {
  const SendLoading({super.key});

  @override
  _SendLoadingState createState() => _SendLoadingState();
}

class _SendLoadingState extends State<SendLoading> {
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
                SizedBox(height: 150),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('소중한 추억의 조각, 우리의 교환일기',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 7),
                      Text('나의 일기가 친구의 행성으로 출발했어요',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 15)),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Flexible(
                    flex: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Lottie.asset('assets/lottie/star-twinkle.json',
                              height: 100),
                        ),
                        Flexible(
                          flex: 3,
                          child: Lottie.asset(
                              'assets/lottie/friend_planet.json',
                              height: 300),
                        ),
                        Flexible(
                          flex: 1,
                          child: Lottie.asset('assets/lottie/star-twinkle.json',
                              height: 100),
                        )
                      ],
                    )),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/exchange_small.json',
                          width: 70, height: 70),
                      Text('안전하게 날아가는중',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w700)),
                      Lottie.asset('assets/lottie/exchange_small.json',
                          width: 70, height: 70)
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
                        SizedBox(height: 20),
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
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
