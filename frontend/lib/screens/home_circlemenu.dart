import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radius = 180;

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/img/background.png'),
            ),
          ),
          child: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: AssetImage('assets/gif-file/moon_real.gif'),
                // backgroundimage AssetImage('assets/gif-file/moon.gif'),
              ),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        radius * cos(radians(-75)), radius * sin(radians(-75))),
                  child: Text('카드 만들기', style: TextStyle(fontSize: 15,color: Colors.white),)),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        radius * cos(radians(-45)), radius * sin(radians(-45))),
                  child: Text('일기 쓰기', style: TextStyle(fontSize: 15,color: Colors.white),)),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        radius * cos(radians(-15)), radius * sin(radians(-15))),
                  child: Text('카드 보관함', style: TextStyle(fontSize: 15,color: Colors.white),)),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        radius * cos(radians(15)), radius * sin(radians(15))),
                  child: Text('일기장', style: TextStyle(fontSize: 15,color: Colors.white),)),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        radius * cos(radians(45)), radius * sin(radians(45))),
                  child: Text('친구', style: TextStyle(fontSize: 15,color: Colors.white),)),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        radius * cos(radians(75)), radius * sin(radians(75))),
                  child: Text('마이페이지', style: TextStyle(fontSize: 15,color: Colors.white),)),
            ],
          ))),
    );
  }
}
