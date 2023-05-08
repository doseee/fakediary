import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../model/CardModel.dart';
import '../services/api_service.dart';

class MoodSelect extends StatefulWidget {
  const MoodSelect({super.key, required this.selectedCards});

  final List<CardModel> selectedCards;
git stat
  @override
  State<MoodSelect> createState() => _MoodSelectState();
}

class _MoodSelectState extends State<MoodSelect> {
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
    'COMFORTING': '위로하는',
    'HAPPY': '행복한',
    'ACTION': '액션',
    'COMIC': '코믹',
  };

  // STORY MOOD 텍스트 아래 10개의 버튼들을 누를 때 작동하는 함수
  setter(String content) {
    // 이미 2개가 선택되었을 경우 기존에 선택된 것을 해제
    if (!activated[content]! && selectedMood.length == 2) {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff0F2027),
              Color(0xff203A43),
              Color(0xff2C5364),
            ],
            stops: [0, 0.4, 1.0],
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
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < selectedMood.length; i++)
                    GradientButton(content: dict[selectedMood[i]]!),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'STORY MOOD',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '작성된 일기의 장르를 골라주세요 (최대 2개)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GradientSelectButton(
                          content: 'SAD',
                          setter: setter,
                          activated: activated['SAD']!,
                          dict: dict,
                        ),
                        GradientSelectButton(
                          content: 'TOUCHING',
                          setter: setter,
                          activated: activated['TOUCHING']!,
                          dict: dict,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                    GestureDetector(
                      onTap: () async {
                        if (selectedMood.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('장르를 선택해주세요'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          return;
                        }
                        List<Map<String, String>> messages = [];
                        String person = '';
                        List<String> baseNames = widget.selectedCards
                            .map((card) => card.baseName.trim())
                            .where((baseName) => baseName.isNotEmpty)
                            .toSet()
                            .toList();
                        if (baseNames.isNotEmpty) {
                          person = '등장인물은 ';
                          for (int i = 0; i < baseNames.length; i++) {
                            if (baseNames[i].trim() != '') {
                              person += baseNames[i];
                            }
                            if (i < baseNames.length - 1) {
                              person += ', ';
                            } else {
                              person += '이고 ';
                            }
                          }
                        }
                        String location = '';
                        List<String> basePlaces = widget.selectedCards
                            .map((card) => card.basePlace.trim())
                            .where((basePlace) => basePlace.isNotEmpty)
                            .toSet()
                            .toList();
                        if (basePlaces.isNotEmpty) {
                          location = '장소는 ';
                          for (int i = 0; i < basePlaces.length; i++) {
                            if (basePlaces[i].trim() != '') {
                              location += basePlaces[i];
                            }
                            if (i < basePlaces.length - 1) {
                              location += ', ';
                            } else {
                              location += '이고 ';
                            }
                          }
                        }
                        String keyword2 = '';
                        List<String> keywords = widget.selectedCards
                            .expand((card) => card.keywords)
                            .where((keyword) => keyword.isNotEmpty)
                            .toSet()
                            .toList();
                        if (keywords.isNotEmpty) {
                          keyword2 = '키워드는 ';
                          for (int i = 0; i < keywords.length; i++) {
                            if (keywords[i].trim() != '') {
                              keyword2 += keywords[i];
                            }
                            if (i < keywords.length - 1) {
                              keyword2 += ', ';
                            } else {
                              keyword2 += '.';
                            }
                          }
                        }
                        String genre2 = '장르는 ';
                        for (int i = 0; i < selectedMood.length; i++) {
                          if (selectedMood[i].trim() != '') {
                            genre2 += dict[selectedMood[i]]!;
                          }
                          if (i < selectedMood.length - 1) {
                            genre2 += ', ';
                          } else {
                            genre2 += '이고 ';
                          }
                        }
                        if (keywords.isEmpty && genre2.endsWith('이고 ')) {
                          genre2 = '${genre2.substring(0, genre2.length - 3)}.';
                        }
                        String prp = person + location + genre2 + keyword2;
                        print(prp);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                                child: Text('다이어리 생성 중입니다. 완료 시 알림이 나타납니다.')),
                          ),
                        );
                        messages = await ApiService.askGpt4(messages, prp);
                        String jsonResp = '';
                        for (var message in messages) {
                          if (message['role'] == 'assistant') {
                            jsonResp = jsonResp + message['content']!;
                          }
                        }
                        final decoded = json.decode(jsonResp);
                        String title = decoded['title'];
                        String summary = decoded['summary'];
                        List<dynamic> contents = decoded['contents'];
                        String detail = contents.join('@');
                        List<dynamic> subtitles = decoded['subtitles'];
                        String subtitle = subtitles.join('@');
                        List<int> cardIds = widget.selectedCards
                            .map((card) => card.cardId)
                            .toList();
                        String coverImg =
                            await ApiService.makeCoverImage(summary);
                        List<String> diaryImageUrl = [];
                        diaryImageUrl.add(coverImg);
                        print(diaryImageUrl.length);
                        diaryImageUrl = [];
                        String keyword = keywords.join('@');
                        List<String> genre = [];
                        for (var i = 0; i < selectedMood.length; i++) {
                          genre.add(selectedMood[i]);
                        }

                        await ApiService.makeDiary(
                            cardIds: cardIds,
                            detail: detail,
                            diaryImageUrl: diaryImageUrl,
                            genre: genre,
                            prompt: prp,
                            subtitles: subtitle,
                            summary: summary,
                            title: title);

                        const AndroidNotificationDetails
                            androidNotificationDetails =
                            AndroidNotificationDetails(
                                'your channel id', 'your channel name',
                                channelDescription: 'your channel description',
                                importance: Importance.max,
                                priority: Priority.high,
                                ticker: 'ticker');
                        const NotificationDetails notificationDetails =
                            NotificationDetails(
                                android: androidNotificationDetails);
                        await FlutterLocalNotificationsPlugin().show(0,
                            '일기 생성 완료', '일기 생성이 완료되었습니다!', notificationDetails,
                            payload: 'item x');
                      },
                      child: Container(
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
                            'MAKE YOUR OWN DIARY',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
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

class GradientButton extends StatelessWidget {
  final String content;

  const GradientButton({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
}
