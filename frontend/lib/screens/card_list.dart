import 'package:flutter/material.dart';
import 'package:frontend/screens/menu_screen.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class CardModal extends StatelessWidget {
  //모달창 class
  final int cardIndex;
  final List cardTitle;

  const CardModal({Key? key, required this.cardIndex, required this.cardTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
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
          image: DecorationImage(
            image: AssetImage('assets/img/bg_galaxy.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text(cardTitle[cardIndex],
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          body: Padding(
            padding: EdgeInsets.all(40),
            child: Row(
              children: [
                Flexible(flex: 1, child: Container(decoration: BoxDecoration(color: Colors.white),)),
                Flexible(flex: 1, child: Container(decoration: BoxDecoration(color: Colors.black),))
              ],
            ),
          ),
        ));
  }
}

class _CardListState extends State<CardList> {
  List temp = [
    '박소정',
    '바나프레소',
    '박박',
    'IAM',
    'ㄹㄹ',
    'ㄱㄱㄱㄱ',
    '하하하하',
    '즐거운하루^^',
    '박소정',
    '바나프레소',
    '박박',
    'IAM',
    'ㄹㄹ',
    'ㄱㄱㄱㄱ',
    '하하하하',
    '즐거운하루^^'
  ];

  Widget build(BuildContext context) {
    return (Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.3,
                  0.6,
                  0.9
                ],
                colors: [
                  Color(0xff0f2027),
                  Color(0xff203a43),
                  Color(0xff2c5364),
                ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1183,
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen()));
                            },
                            child: Image(
                              image: AssetImage(
                                'assets/img/icon_menu_page.png',
                              ),
                              width: 45,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            body: Center(
                child: Column(children: [
                  Flexible(
                    flex: 1,
                    child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image:
                                AssetImage('assets/img/cardlist_topcards.png'),
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(height: 15,),
                              Text('내가 만든 카드를 확인해보세요',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white)),
                              Text('카드를 누르면 해당 카드로 생성한 일기가 나타납니다.',
                                  style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                              SizedBox(height: 10,),
                              Image(
                                image: AssetImage('assets/img/line_top.png'),
                                width: 200,
                                height: 40,
                              )
                            ],
                          ),
                        )),
                  ),
                  Flexible(
                      flex: 3,
                      child: GridView.count(
                        crossAxisCount: 3,
                        // 가로 방향으로 3개의 카드씩 표시
                        childAspectRatio: 0.7,
                        // 카드의 가로 세로 비율 설정
                        mainAxisSpacing: 10.0,
                        // 카드들의 세로 간격 설정
                        crossAxisSpacing: 10.0,
                        // 카드들의 가로 간격 설정
                        padding: EdgeInsets.all(10.0),
                        // GridView 자체의 Padding 설정
                        children: List.generate(
                          // 카드 리스트 생성
                          temp.length, // 총 카드 갯수
                              (index) {
                            return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => CardModal(
                                        cardIndex: index, cardTitle: temp),
                                  );
                                },
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 0.0,
                                  child: Column(
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage(
                                            'assets/img/cardlist_tmpcard.png'),
                                        height: 110,
                                        width: 110,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(temp[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      )),
                ])))));
  }
}
