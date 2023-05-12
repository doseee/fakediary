import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Colors.amber
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff0A3442), Color(0xff4F4662)],
            stops: [0.4, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(80),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(),
              ),
              // Flexible(
              //   flex: 2,
              //   child: Container(
              //     decoration: BoxDecoration(color: Colors.blueGrey),
              //     child: Center(
              //       child: Text('AD',
              //           style: TextStyle(
              //               fontWeight: FontWeight.w700, fontSize: 24)),
              //     ),
              //   ),
              // ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 10,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/example.jpg'))),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: SpinKitFadingCircle(
                            color: Colors.black,
                            size: 70.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Flexible(flex: 2, child: Center(
              //   child: SpinKitFadingCube(
              //     color: Colors.white70,
              //     size: 40.0,
              //   ),
              // )),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // const SizedBox(width: 20.0, height: 100.0),
                    // const Text(
                    //   'Be',
                    //   style: TextStyle(fontSize: 43.0),
                    // ),
                    // const SizedBox(width: 20.0, height: 100.0),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Horizon',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('작가 한강과 콜라보레이션 중...'),
                          RotateAnimatedText('GPT와 인생에 대한 대화를 나누는 중...'),
                          RotateAnimatedText('사용자를 기다리게 하며 약올리는 중...'),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
