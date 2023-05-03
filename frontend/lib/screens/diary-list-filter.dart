import 'package:flutter/material.dart';
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
                        ),]
                    ),
                    Row(
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
                    Container(
                      width: 268,
                      height: 61,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/background_1.png'),
                          fit: BoxFit.cover,
                        ),
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
