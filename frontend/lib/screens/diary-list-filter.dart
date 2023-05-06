// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/model/FriendModel.dart';
import 'package:frontend/services/api_service.dart';
import 'package:gradient_borders/gradient_borders.dart';

class DiaryFilter extends StatefulWidget {
  const DiaryFilter({super.key});

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
    // // 이미 2개가 선택되었을 경우 작동하지 않음
    // if (!activated[content]! &&
    //     selectedMood.length == 2 &&
    //     !selectedMood.contains(content)) {
    //   return;
    // }

    // 이미 2개가 선택되었을 경우 기존에 선택된 것을 해제
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

  // final romanceSelected = false;
  // final horrorSeleted = false;
  // final thrillSelected = false;
  // final warmSelected = false;
  // final sadSelected = false;
  // final touchingSelected = false;
  // final comfortingSelected = false;
  // final happySelected = false;
  // final actionSelected = false;
  // final comicSelected = false;

  late Future<List<FriendModel>> friends;
  // final int friendIndex;
  // final String nickname;
  // const FriendModel({Key? key, required this.friendIndex, required this.nickname})
  // : super(key: key);

  @override
  void initState() {
    super.initState();
    friends = ApiService().getFriends();
    print(friends);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background_pink_darken.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        '      MOOD  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GradientSelectButton(
                        content: 'ROMANCE',
                        setter: setter,
                        activated: activated['ROMANCE']!,
                        dict: dict,
                      ),
                      GradientSelectButton(
                        content: 'HORROR',
                        setter: setter,
                        activated: activated['HORROR']!,
                        dict: dict,
                      ),
                      GradientSelectButton(
                        content: 'THRILL',
                        setter: setter,
                        activated: activated['THRILL']!,
                        dict: dict,
                      ),
                      GradientSelectButton(
                        content: 'WARM',
                        setter: setter,
                        activated: activated['WARM']!,
                        dict: dict,
                      ),
                      GradientSelectButton(
                        content: 'SAD',
                        setter: setter,
                        activated: activated['SAD']!,
                        dict: dict,
                      ),
                    ]),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GradientSelectButton(
                      content: 'TOUCHING',
                      setter: setter,
                      activated: activated['TOUCHING']!,
                      dict: dict,
                    ),
                    GradientSelectButton(
                      content: 'COMFORTING',
                      setter: setter,
                      activated: activated['COMFORTING']!,
                      dict: dict,
                    ),
                    GradientSelectButton(
                      content: 'HAPPY',
                      setter: setter,
                      activated: activated['HAPPY']!,
                      dict: dict,
                    ),
                    GradientSelectButton(
                      content: 'ACTION',
                      setter: setter,
                      activated: activated['ACTION']!,
                      dict: dict,
                    ),
                    GradientSelectButton(
                      content: 'COMIC',
                      setter: setter,
                      activated: activated['COMIC']!,
                      dict: dict,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      '      WRITER  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                          // 필터적용 버튼
                          width: 268,
                          height: 61,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xff263344),
                                const Color(0xff1B2532).withOpacity(0.53),
                                const Color(0xff1C2A3D).withOpacity(0.5),
                                const Color(0xff1E2E42).withOpacity(0.46),
                                const Color(0xff364B66).withOpacity(0.33),
                                const Color(0xff2471D6).withOpacity(0),
                              ],
                              stops: const [0, 0.25, 0.4, 0.5, 0.75, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              '검색하기',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )),
                      Container(
                          // 필터적용 버튼
                          width: 268,
                          height: 61,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xff263344),
                                const Color(0xff1B2532).withOpacity(0.53),
                                const Color(0xff1C2A3D).withOpacity(0.5),
                                const Color(0xff1E2E42).withOpacity(0.46),
                                const Color(0xff364B66).withOpacity(0.33),
                                const Color(0xff2471D6).withOpacity(0),
                              ],
                              stops: const [0, 0.25, 0.4, 0.5, 0.75, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              '취소',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )),
                      Image(
                        image: AssetImage('assets/img/small_moon.png'),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 5,
                  child: FutureBuilder<List<FriendModel>>(
                      future: friends,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return buildList(snapshot.data);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}에러!!");
                        }
                        return CircularProgressIndicator();
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildList(snapshot) {
  return (GridView.count(
    crossAxisCount: 3,
    // 가로 방향으로 3개의 카드씩 표시
    crossAxisSpacing: 10.0,
    // 카드들의 가로 간격 설정
    padding: EdgeInsets.all(10.0),
    // GridView 자체의 Padding 설정
    children: List.generate(
      // 카드 리스트 생성
      snapshot.length, // 총 카드 갯수
      (index) {
        if (snapshot.length == 0) {
          return Container(
            child: SpinKitFadingCircle(
              color: Colors.black,
              size: 70.0,
            ),
          );
        } else {
          return InkWell(
              onTap: () {},
              child: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Text('friends.[nickname]')));
        }
      },
    ),
  ));
}

class GradientButton extends StatelessWidget {
  final String content;

  const GradientButton({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff79F1A4),
              Color(0xff0E5CAD),
            ],
            stops: [0, 1.0],
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff79F1A4),
            Color(0xff0E5CAD),
          ],
          stops: [0, 1.0],
        ),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class GradientSelectButton extends StatelessWidget {
  final String content;
  final Function setter;
  final bool activated;
  final Map<String, String> dict;

  const GradientSelectButton({
    super.key,
    required this.content,
    required this.setter,
    required this.activated,
    required this.dict,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setter(content);
      },
      child: Container(
        width: 65,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff79F1A4),
                Color(0xff0E5CAD),
              ],
              stops: [0, 1.0],
            ),
          ),
          gradient: activated
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff79F1A4),
                    Color(0xff0E5CAD),
                  ],
                  stops: [0, 1.0],
                )
              : null,
        ),
        child: Center(
          child: Text(
            dict[content]!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
