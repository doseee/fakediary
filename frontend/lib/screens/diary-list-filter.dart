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

final selectedMood = [];
final selectedWriter = [];

class _DiaryFilterState extends State<DiaryFilter> {
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

  moodSetter(String mood) {
    selectedMood.add(mood);
  }

  writerSetter(dynamic writerNickname) {
    selectedWriter.add(writerNickname);
  }

  late Future<List<FriendModel>> friends;

  void initState() {
    super.initState();
    friends = ApiService().getFriends();
    print(friends);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GradientButton(content: dict[selectedMood[0]]!),
                  GradientButton(content: selectedWriter.isNotEmpty ? selectedWriter[0] : null)
                ],
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
                        mood: 'ROMANCE',
                        setter: moodSetter,
                        dict: dict,
                      ),
                      MoodSelectButton(
                        mood: 'HORROR',
                        setter: moodSetter,
                        dict: dict,
                      ),
                      MoodSelectButton(
                        mood: 'THRILL',
                        setter: moodSetter,
                        dict: dict,
                      ),
                      MoodSelectButton(
                        mood: 'WARM',
                        setter: moodSetter,
                        dict: dict,
                      ),
                      MoodSelectButton(
                        mood: 'SAD',
                        setter: moodSetter,
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
                      mood: 'TOUCHING',
                      setter: moodSetter,
                      dict: dict,
                    ),
                    MoodSelectButton(
                      mood: 'COMFORTING',
                      setter: moodSetter,
                      dict: dict,
                    ),
                    MoodSelectButton(
                      mood: 'HAPPY',
                      setter: moodSetter,
                      dict: dict,
                    ),
                    MoodSelectButton(
                      mood: 'ACTION',
                      setter: moodSetter,
                      dict: dict,
                    ),
                    MoodSelectButton(
                      mood: 'COMIC',
                      setter: moodSetter,
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
              Flexible(
                  flex: 1,
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
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              color: const Color(0xff000000).withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            '검색하기',
                            style: TextStyle(color: Colors.white, fontSize: 15),
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

Widget buildList(snapshot) {
  return ListView.builder(
    scrollDirection: Axis.horizontal, // 리스트 방향을 가로로 설정
    itemCount: snapshot.length, // 리스트 아이템 갯수는 snapshot 길이와 같음
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://play-lh.googleusercontent.com/38AGKCqmbjZ9OuWx4YjssAz3Y0DTWbiM5HB0ove1pNBq_o9mtWfGszjZNxZdwt_vgHo=w240-h480-rw'),
              radius: 15.0,

            ),
            SizedBox(
              width: 5,
            ),
            Card(
              color: Colors.transparent,
              elevation: 0.0,
              child:
              Text(
                snapshot[index].nickname,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),)
          ],
        ),
      );
    },
  );
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

class WriterSelectButton extends StatelessWidget {
  // 유저 버튼
  final dynamic writer;
  final Function setter;

  const WriterSelectButton({
    super.key,
    required this.writer,
    required this.setter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectedWriter.isNotEmpty && selectedWriter[0] == writer) {
          selectedWriter.clear();
        } else {
          setter(writer);
        }
      },
      child: Container(
        width: 100,
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
          gradient: selectedWriter.isNotEmpty && selectedWriter[0] == writer
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
            'writer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }


} // 유저버튼


class MoodSelectButton extends StatelessWidget {
  //장르버튼
  final String mood;
  final Function setter;
  final Map<String, String> dict;

  const MoodSelectButton({
    super.key,
    required this.mood,
    required this.setter,
    required this.dict,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectedMood.isNotEmpty && selectedMood[0] == mood) {
          selectedMood.remove(mood);
        } else {
          selectedMood.clear();
          selectedMood.add(mood);
        }
      },
      child: Container(
        width: 140,
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
          gradient: selectedMood.isNotEmpty && selectedMood[0] == mood
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
            dict[selectedMood]!,
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

