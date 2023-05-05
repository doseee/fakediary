import 'package:flutter/material.dart';

class DiaryFilter extends StatefulWidget {
  const DiaryFilter({Key? key}) : super(key: key);

  @override
  State<DiaryFilter> createState() => _DiaryFilterState();
}

class _DiaryFilterState extends State<DiaryFilter> {
  final selectedMood = [];
  final activated = {
    'ROMANCE': false,
    'HORROR': false,
    'THRILL': false,
    'WARM': false,
    'SAD': false,
    'TOUCHING': false,
    'COMFORTING': false,
    'HAPPY': false,
    'ACTION': false,
    'COMIC': false,
  };
  final dict = {
    'ROMANCE': '로맨스',
    'HORROR': '호러',
    'THRILL': '스릴',
    'WARM': '따뜻한',
    'SAD': '슬픈',
    'TOUCHING': '감동적인',
    'COMFORTING': '위로 하는',
    'HAPPY': '행복한',
    'ACTION': '액션',
    'COMIC': '코믹',
  };

  setter(String content) {

    // 이미 1개가 선택되었을 경우 기존에 선택된 것을 해제
    if (!activated[content]! && selectedMood.length == 1) {
      activated[selectedMood[0]] = false;
      selectedMood.removeAt(0);
    }

    // 나머지 경우 선택 상태를 반전
    activated[content] = !activated[content]!;
    if (activated[content]!) {
      selectedMood.add(content);
    } else {
      selectedMood.remove(content);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
