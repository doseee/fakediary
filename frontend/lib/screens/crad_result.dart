import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';

class CardResult extends StatefulWidget {
  const CardResult({Key? key}) : super(key: key);

  @override
  State<CardResult> createState() => _CardResultState();
}

Widget _buttonList(BuildContext context) {
  return Container(
    width: 350,
    height: 50,
    decoration: BoxDecoration(
        border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Color(0xff79F1A4),
              Color(0xff0E5CAD),
            ]),
            width: 2),
        borderRadius: BorderRadius.circular(25)),
    child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
        child: Text(
          '카드 목록 확인하기',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
        )),
  );
}

class _CardResultState extends State<CardResult>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFrontVisible = true; //앞뒤 구분
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff0A3442), Color(0xff4F4662)],
          stops: [0.4, 1.0],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(left: 60, right: 60),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Lottie.asset('assets/lottie/105550sparkle.json'),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Flexible(
                          flex: 2,
                          child: Center(
                            child: Text(
                              '오늘의 기억 조각 완성 !',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                      Flexible(
                        flex: 1,
                        child: Text('카드를 터치해보세요',
                            style: TextStyle(color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                Flexible(
                    flex: 9,
                    child: GestureDetector(
                        onTap: () {
                          _toggleCardExpansion();
                        },
                        child: AnimatedOpacity(
                          opacity: opacityLevel,
                          duration: Duration(seconds: 3),
                          child: Center(
                            child: Transform(
                              transform:
                              Matrix4.rotationY(_animation.value * 3.14),
                              alignment: Alignment.center,
                              child: _isFrontVisible
                                  ? _buildFront()
                                  : _buildBack(),
                            ),
                          ),
                        ))),
                Flexible(
                    flex: 3,
                    child: Center(
                      child: _buttonList(context),
                    )),
              ],
            ),
          )),
    );
  }

  Widget _buildBack() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: 10,
          color: Color(0xffECE0CA),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child:Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(),
          ),
          Flexible(
            flex: 1,
            child: Container(
                decoration: BoxDecoration(color: Colors.white)),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          )
        ],
      ),
    );
  }

  Widget _buildFront() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                image: AssetImage('assets/img/cards.jpg'), fit: BoxFit.cover),
            border: Border.all(width: 10, color: Colors.grey)));
  }

  void _toggleCardExpansion() {
    if (_isFrontVisible) {
      _controller.forward().then((value) {
        setState(() {
          _isFrontVisible = false;
        });
      });
    } else {
      _controller.reverse().then((value) {
        setState(() {
          _isFrontVisible = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
