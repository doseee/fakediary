import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final radius = 180;

    return Scaffold(
      body: Container(
          child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                  image: AssetImage('assets/gif-file/moon.gif'),
                    // backgroundimage AssetImage('assets/gif-file/moon.gif'),
                  ),

                  Text('행성'),
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(radius * cos(radians(-75)),
                            radius * sin(radians(-75))),
                      child: Text('카드 만들기')
                  ),
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(radius * cos(radians(-45)),
                            radius * sin(radians(-45))),
                      child: Text('일기 쓰기')
                  ),
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(radius * cos(radians(-15)),
                            radius * sin(radians(-15))),
                      child: Text('카드 보관함')
                  ),
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(radius * cos(radians(15)),
                            radius * sin(radians(15))),
                      child: Text('일기장')
                  ),
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(radius * cos(radians(45)),
                            radius * sin(radians(45))),
                      child: Text('친구')
                  ),
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(radius * cos(radians(75)),
                            radius * sin(radians(75))),
                      child: Text('마이페이지')
                  ),
                ],
              )
          )
      ),
    );
  }
}