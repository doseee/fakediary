// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:frontend/model/DiaryModel.dart';

// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/model/FriendModel.dart';
import 'package:frontend/screens/diary_list_filtered_screen.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryFilter extends StatefulWidget {
  const DiaryFilter({super.key});

  @override
  State<DiaryFilter> createState() => _DiaryFilterState();
}

late dynamic userId;
dynamic selectedMood;

class _DiaryFilterState extends State<DiaryFilter> {
  Map<String, dynamic> selectedWriter = {};

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

  moodSetter(moodname) {
    if (activated[moodname] == true) {
      activated[moodname] = false;
      selectedMood = null;
    } else {
      activated.updateAll((key, value) => false);
      activated[moodname] = true;
      selectedMood = moodname;
    }
    setState(() {});
    print(selectedMood);
    // 이미 2개가 선택되었을 경우 기존에 선택된 것을 해제
    // if (!activated[content]! && selectedMood.length == 1) {
    //   activated[selectedMood[0]] = false;
    //   selectedMood.removeAt(0);
    // }

    // 나머지 경우 선택 상태를 반전
    // activated[content] = !activated[content]!;
    // if (activated[content]!) {
    //   selectedMood.add(content);
    // } else {
    //   selectedMood.remove(content);
    // }
  }

  writerSetter(nickname, friendId) {
    if (selectedWriter.length == 1) {
      if (selectedWriter.containsKey(nickname)) {
        selectedWriter.clear();
      } else {
        selectedWriter.clear();
        selectedWriter[nickname] = friendId;
      }
    } else {
      selectedWriter[nickname] = friendId;
    }
    setState(() {});
    print(selectedWriter);
  }

  late Future<List<FriendModel>> friends;

  void initState() {
    super.initState();
    _loadId();
    friends = ApiService().getFriends();
    print(friends);
  }

  Future<void> _loadId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    userId = memberId;
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  'FILTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (selectedMood != null)
                      GradientButton(content: dict[selectedMood]!),
                    if (selectedWriter.isNotEmpty &&
                        selectedWriter.keys.first.toString() != '외계인')
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://play-lh.googleusercontent.com/38AGKCqmbjZ9OuWx4YjssAz3Y0DTWbiM5HB0ove1pNBq_o9mtWfGszjZNxZdwt_vgHo=w240-h480-rw'),
                            radius: 15.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            selectedWriter.keys.first.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    if (selectedWriter.isNotEmpty &&
                        selectedWriter.keys.first.toString() == '외계인')
                      Row(
                        children: [
                          Container(
                            child: Lottie.asset('assets/lottie/random.json'),
                            width: 40,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            selectedWriter.keys.first.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Flexible(
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
              Flexible(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MoodSelectButton(
                        content: 'ROMANCE',
                        setter: moodSetter,
                        activated: activated['ROMANCE']!,
                        dict: dict,
                      ),
                      MoodSelectButton(
                        content: 'HORROR',
                        setter: moodSetter,
                        activated: activated['HORROR']!,
                        dict: dict,
                      ),
                      MoodSelectButton(
                        content: 'THRILL',
                        setter: moodSetter,
                        activated: activated['THRILL']!,
                        dict: dict,
                      ),
                      MoodSelectButton(
                        content: 'WARM',
                        setter: moodSetter,
                        activated: activated['WARM']!,
                        dict: dict,
                      ),
                      MoodSelectButton(
                        content: 'SAD',
                        setter: moodSetter,
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
                    MoodSelectButton(
                      content: 'TOUCHING',
                      setter: moodSetter,
                      activated: activated['TOUCHING']!,
                      dict: dict,
                    ),
                    MoodSelectButton(
                      content: 'COMFORTING',
                      setter: moodSetter,
                      activated: activated['COMFORTING']!,
                      dict: dict,
                    ),
                    MoodSelectButton(
                      content: 'HAPPY',
                      setter: moodSetter,
                      activated: activated['HAPPY']!,
                      dict: dict,
                    ),
                    MoodSelectButton(
                      content: 'ACTION',
                      setter: moodSetter,
                      activated: activated['ACTION']!,
                      dict: dict,
                    ),
                    MoodSelectButton(
                      content: 'COMIC',
                      setter: moodSetter,
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
              // Flexible(
              //     flex: 1,
              //     child: Row(children: [
              //       Container(
              //         child:
              //             Lottie.asset('assets/lottie/random.json', width: 60),
              //       ),
              //       Text(
              //         '외계인',
              //         style: TextStyle(color: Colors.white),
              //       )
              //     ])),
              Flexible(
                  flex: 1,
                  child: FutureBuilder<List<FriendModel>>(
                      future: friends,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return buildList(snapshot.data, writerSetter);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}에러!!");
                        }
                        return CircularProgressIndicator();
                      })),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        // onTap: () {
                        //   ApiService.filterDiaries(
                        //       selectedMood,
                        //       selectedWriter.isEmpty? null :
                        //       selectedWriter.values.first);
                        //   Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //   builder: (context) => DiaryListScreen()));
                        // },
                        onTap: () async {
                          List<DiaryModel> filteredDiaries =
                              await ApiService.filterDiaries(
                            selectedMood,
                            selectedWriter.isEmpty
                                ? null
                                : selectedWriter.values.first,
                          );
                          print(filteredDiaries);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiaryFilteredScreen(
                                diaries: filteredDiaries,
                              ),
                            ),
                          );
                        },
                        child: Container(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ))),
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
                              color: const Color(0xff000000).withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            '취소',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )),
                    Image(
                      image: AssetImage('assets/img/small_moon.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildList(snapshot, setter) {
  //유저버튼
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          setter('외계인', -1);
        },
        child: Row(
          children: [
            Container(
              child: Lottie.asset('assets/lottie/random.json', width: 60),
            ),
            Text(
              '외계인',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          setter('나', userId);
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://play-lh.googleusercontent.com/38AGKCqmbjZ9OuWx4YjssAz3Y0DTWbiM5HB0ove1pNBq_o9mtWfGszjZNxZdwt_vgHo=w240-h480-rw'),
              radius: 15.0,
            ),
            SizedBox(width: 5),
            Text(
              '나',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: double.infinity,
              width: 0.1,
              color: Colors.white,
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setter(snapshot[index].nickname, snapshot[index].friendId);
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://play-lh.googleusercontent.com/38AGKCqmbjZ9OuWx4YjssAz3Y0DTWbiM5HB0ove1pNBq_o9mtWfGszjZNxZdwt_vgHo=w240-h480-rw'),
                      radius: 15.0,
                    ),
                    SizedBox(width: 5),
                    Card(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Text(
                        snapshot[index].nickname,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

class GradientButton extends StatelessWidget {
  // 상단에 올라갈 장르버튼
  final String content;

  const GradientButton({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
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

class MoodSelectButton extends StatelessWidget {
  //장르버튼
  final String content;
  final Function setter;
  final bool activated;
  final Map<String, String> dict;

  const MoodSelectButton({
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
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
} //장르버튼
