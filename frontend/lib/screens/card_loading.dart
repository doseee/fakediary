import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardLoading extends StatelessWidget {
  CardLoading({super.key});
  final Random _random = Random();
  final List<String> loadingImages = [
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/7084041710e74b2ab8ee5c24c82292b7.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/cdbe6d39e3fa45ce8cabba47a309bc6e.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/c0bade57d10b4fb39665ba1518e1f194.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/5c01c52d10674fbbae50faae412b4b84.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/a133d514e304466f930856b3d2e57995.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/d69722f62b514f6bbb3d0109eab5895e.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/06b23b550ecd452e939137bcdb2235a3.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/8770d61e7c6a4a80acfaaeb5c4aeee4e.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/3f63f74fa89f48dcaa6bfa236d3cfe70.jpg",
    "http://fakediary.s3.ap-northeast-2.amazonaws.com/88f8d047f6b54c96bccf765c4dd2209a.jpg",
  ];
  final List<String> loadingTexts = [
    '작가 한강과 콜라보레이션 중...',
    'GPT와 인생에 대한 대화를 나누는 중...',
    '개발자가 수동으로 카드 제작하는 중...',
    '코드에 숨겨놓은 투명문자 지우는 중...',
    '사용자를 기다리게 하며 약올리는 중...',
    '고양이와 카드 스타일 의논하는 중...',
    '구글, 아마존과 업무 협의 중...',
    '관련 없는 이미지로 바꿔치는 중...',
    '그림 대신 광고를 띄울지 고민하는 중...',
    '점성술로 사진 속의 대상을 분석 중...',
  ];

  @override
  Widget build(BuildContext context) {
    final String randomImageUrl =
        loadingImages[_random.nextInt(loadingImages.length)];
    loadingTexts.shuffle(_random);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff0A3442), Color(0xff4F4662)],
            stops: [0.4, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Text(
                      '조금만 기다려 주세요',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                ],
              )),
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: Container(
                  width: 474,
                  height: 840,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(randomImageUrl),
                    fit: BoxFit.contain,
                  )),
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: Colors.black,
                      size: 70.0,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Horizon',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: loadingTexts
                            .map((text) => RotateAnimatedText(text))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
