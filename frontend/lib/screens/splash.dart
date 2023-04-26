import 'package:flutter/material.dart';
import 'package:frontend/screens/login_entrance.dart';
import 'package:lottie/lottie.dart';
import 'package:frontend/screens/home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginEntrance()),
            (route) => false));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.3,
                0.6,
                0.9
              ],
                  colors: [
                Color(0xff0f2027),
                Color(0xff203a43),
                Color(0xff2c5364),
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  child: Lottie.asset(
                      'assets/lottie/book-loop-perspective.json',
                      controller: _controller, onLoaded: (composition) {
                _controller.addStatusListener((status) {
                  if (status == AnimationStatus.dismissed) {
                    _controller.forward();
                  } else if (status == AnimationStatus.completed) {
                    _controller.reverse();
                  }
                });

                _controller
                  ..duration = composition.duration
                  ..forward();
              })),
              const SizedBox(
                child: Text('Lieary',
                    style: TextStyle(
                        color: Color(0xff1C333C), fontWeight: FontWeight.w900)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
