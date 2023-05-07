import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/ChangeButton.dart';
import 'package:frontend/widgets/dashed_line.dart';
import 'package:frontend/widgets/diary_detail_card_list.dart';
import 'package:frontend/widgets/theme.dart';

import '../widgets/line_img_animation.dart';
import '../widgets/line_widget.dart';

class DiaryDetailScreen extends StatefulWidget {
  final int diaryId;

  /// 1 or 2는 내 일기라서 카드, 교환 버튼 표시
  /// 3은 친구 일기라 카드, 교환버튼 표시 안됨
  final int exchangeSituation;

  const DiaryDetailScreen(
      {Key? key, required this.diaryId, required this.exchangeSituation})
      : super(key: key);

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  late ScrollController _scrollController;

  List allSlides = [
    {
      'slideName': '1장, 안드로메다로',
      'selected': false,
      'content':
          '문성현은 안드로메다의 커피숍에서 맛있는 커피를 마시며 느긋한 오후를 보내고 있었다. 그때 커피숍의 주인이 문성현에게 커피 한 잔을 더 주며, "오늘은 특별히 내가 점을 쳐줄게." 라고 말했다.'
    },
    {'slideName': 'slideTwo', 'selected': false, 'content': ''},
    {'slideName': 'slideThree', 'selected': false, 'content': ''},
    {'slideName': 'slideFour', 'selected': false, 'content': ''},
    {'slideName': 'slideFive', 'selected': false, 'content': ''},
    {'slideName': 'slideSix', 'selected': false, 'content': ''},
    {'slideName': 'slideSeven', 'selected': false, 'content': ''},
    {'slideName': 'slideEight', 'selected': false, 'content': ''},
    {'slideName': 'slideNine', 'selected': false, 'content': ''},
  ];

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.yellow,
    Colors.cyan,
    Colors.brown,
    Colors.grey,
  ];

  @override
  void initState() {
    super.initState();
    print(widget.diaryId);

    _scrollController = ScrollController();
  }

  bool fontFam = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BgThemeGradientDiary(),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          controller: _scrollController,
          children: [
            SizedBox(
              height: 500,
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/img/temp.jpg'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: LineImgAnimation(),
                          ),
                          Flexible(
                            flex: 4,
                            child: buildArtworkTitle('말하는 감자의 싸피 일기'),
                          ),
                          Flexible(
                            flex: 1,
                            child: LineWidget(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ...allSlides.map((e) {
              return getCards(e);
            }).toList(),
            CheckFriendLetter(),
          ],
        ),
      ),
    );
  }

  Widget CheckCard(){
    if(colors.isEmpty){
      return Container();
    }

    return DiaryDetailCardList(colors: colors);
  }


  Widget CheckFriendLetter(){
    if(widget.exchangeSituation == 3){
      return Container();
    }

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Center(child: CheckCard()),
            SizedBox(
              height: 30,
            ),
            ChangeButton(
              exchangeSituation: widget.exchangeSituation,
              diaryId: widget.diaryId,
            )
          ],
        ),
      ),
    );
  }

  Widget getCards(slide) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 25, right: 25),
      child: Container(
          // decoration: BoxDecoration(
          //     border: Border.all(
          //         color: Colors.black, style: BorderStyle.solid, width: 1)),
          width: 150,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Text(
                  slide['slideName'],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      fontFamily: fontFam ? 'Cafe24' : 'Nanum_Square_Neo'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: SizedBox(
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/temp.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    slide['content'],
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, height: 1.5, letterSpacing: 1.1, fontFamily: fontFam ? 'Cafe24' : 'Nanum_Square_Neo'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
                child: DashedLine(),
              )
            ],
          )),
    );
  }

  Widget buildArtworkTitle(title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white,),
      ),
    );
  }
}
