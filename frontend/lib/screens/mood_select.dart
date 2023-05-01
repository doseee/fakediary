import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class MoodSelect extends StatefulWidget {
  const MoodSelect({super.key});

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
    'COMFORTING': '위로를 주는',
    'HAPPY': '행복한',
    'ACTION': '액션',
    'COMIC': '코믹',
  };

  setter(String content) {
    // 이미 2개가 선택되었을 경우 작동하지 않음
    if (!activated[content]! &&
        selectedMood.length == 2 &&
        !selectedMood.contains(content)) {
      return;
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
                  GradientButton(content: '로맨스'),
                  GradientButton(content: '코믹'),
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
                    Container(
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
