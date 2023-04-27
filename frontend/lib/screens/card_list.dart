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

  const CardModal({Key? key, required this.cardIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card ${cardIndex + 1}'),
      ),
      body: Center(
        child: Text('This is Card ${cardIndex + 1}'),
      ),
    );
  }
}



class _CardListState extends State<CardList> {
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
                          Text('내가 만든 카드를 확인해보세요',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white)),
                          Text('카드를 누르면 해당 카드로 생성한 소설이 나타납니다.',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
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
                      15, // 총 카드 갯수
                      (index) {
                        return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    CardModal(cardIndex: index),
                              );
                            },
                            child: Card(
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
                                    child: Text(
                                      'Card ${index + 1}',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
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
