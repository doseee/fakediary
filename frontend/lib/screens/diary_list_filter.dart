import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/model/FriendModel.dart';
import 'package:frontend/services/api_service.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class DiaryFilter extends StatefulWidget {
  const DiaryFilter({super.key});

  @override
  State<DiaryFilter> createState() => _DiaryFilterState();
}

final List<String> genres = [
  'ROMANCE',
  'HORROR',
  'THRILL',
  'WARM',
  'SAD',
  'TOUCHING',
  'COMFORTING',
  'HAPPY',
  'ACTION',
  'COMIC',
];

final selectedMood = [];

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

class _DiaryFilterState extends State<DiaryFilter> {
  late Future<List<FriendModel>> friends;

  void initState() {
    super.initState();
    friends = ApiService().getFriends();
    print(friends);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image(
            image: AssetImage('assets/img/background_pink_darken.png'),
            fit: BoxFit.cover,
          ),
          buildList(genres)
        ])));
  }
}

Widget buildList(genres) {
  return GridView.count(
    crossAxisCount: 6,
    // 가로 방향으로 6개의 버튼씩 표시
    childAspectRatio: 0.7,
    // 버튼 가로 세로 비율 설정
    mainAxisSpacing: 10.0,
    // 버튼 세로 간격 설정
    crossAxisSpacing: 10.0,
    // 버튼 가로 간격 설정
    padding: EdgeInsets.all(10.0),
    // GridView 자체의 Padding 설정
    children: List.generate(
        // 버튼 리스트 생성
        genres.length, // 총 카드 갯수
        (index) {
      if (genres.length == 0) {
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
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GradientSelectButton(
                      content: genres[index],
                      dict: dict,
                    ),
                  ),
                ])));
      }
      ;
    }),
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

class GradientSelectButton extends StatelessWidget {
  final String content;
  final Map<String, String> dict;

  const GradientSelectButton({
    super.key,
    required this.content,
    required this.dict,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
