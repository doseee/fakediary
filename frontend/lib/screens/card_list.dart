import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/model/CardModel.dart';
import 'package:frontend/screens/menu_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/theme.dart';
import '../widgets/appbar.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class CardModal extends StatelessWidget {
  //모달창 class
  final CardModel card;
  final String cardTitle;

  const CardModal({Key? key, required this.card, required this.cardTitle})
      : super(key: key);

  Widget Character() {
    if (card.baseName == '') {
      return Container();
    } else {
      return Flexible(
          flex: 1,
          child: Center(
            child: Row(
              children: [
                Text(
                  '주인공 : ',
                  style: TextStyle(color: Colors.white),
                ),
                Text(card.baseName, style: TextStyle(color: Colors.white)),
              ],
            ),
          ));
    }
  }

  Widget Place() {
    if (card.basePlace == '') {
      return Container();
    } else {
      return Flexible(
          flex: 1,
          child: Center(
              child: Row(
            children: [
              Text(
                '장소 : ',
                style: TextStyle(color: Colors.white),
              ),
              Text(card.basePlace, style: TextStyle(color: Colors.white)),
            ],
          )));
    }
  }

  Widget Kewyords() {
    if (card.keywords.isEmpty) {
      return Container();
    } else {
      String keywords = card.keywords.join(', ');
      return Flexible(
          flex: 1,
          child: Center(
              child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        decoration: BtnThemeGradientLine(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                          child: Text(
                            '키워드',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  )),
              Flexible(
                flex: 1,
                child:  Align(
                  alignment: Alignment.topLeft,
                  child:Text(keywords, style: TextStyle(color: Colors.white)),
                ))
            ],
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    print('cardId : ${card.cardId}');
    return Container(
        decoration: BgThemeIncludeImage(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title:
                Text(cardTitle, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      '기억의 조각이 완성된 날',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Flexible(
                    flex: 1,
                    child: Text(
                      card.createdAt.split('T')[0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Flexible(
                    flex: 11,
                    child: Center(
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Container(
                                width: 200,
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  border: Border.all(
                                      color: Colors.white60, width: 4),
                                  image: DecorationImage(
                                      image: NetworkImage(card.cardImageUrl),
                                      fit: BoxFit.cover),
                                ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              flex: 1,
                              child: Container(
                                width: 200,
                                height: 240,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Character(),
                                        Place(),
                                        Kewyords()
                                      ],
                                    )),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Flexible(flex: 2, child:GestureDetector(
                      onTap: () {
                        print('일기생성');
                      },
                      child: Center(
                        child: Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xff79F1A4),
                                Color(0xff0E5CAD),
                              ]),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                                '일기생성',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              )),
                        ),
                      )),)
                ],
              )
          ),
        ));
  }
}

class _CardListState extends State<CardList> {
  late Future<List<CardModel>> cards;
  late Future<int> lengthOfCards;

  @override
  void initState() {
    super.initState();
    cards = ApiService().getCardList();
    print(cards);
  }

  Widget build(BuildContext context) {
    return (Container(
        decoration: BgThemeGradient(),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: StandAppBar(context),
            body: Center(
                child: Column(children: [
              Flexible(
                flex: 2,
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
                          SizedBox(
                            height: 15,
                          ),
                          Text('내가 만든 카드를 확인해보세요',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white)),
                          Text('카드를 누르면 해당 카드의 상세 정보를 확인할 수 있습니다',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
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
                  flex: 5,
                  child: FutureBuilder<List<CardModel>>(
                      future: cards,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return buildList(snapshot.data);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}에러!!");
                        }
                        return CircularProgressIndicator();
                      })),
            ])))));
  }

  String titleCheck(snapshot, index) {
    if (snapshot[index].keywords.length != 0) {
      return snapshot[index].keywords[0];
    } else if (snapshot[index].baseName != '') {
      return snapshot[index].baseName;
    }

    return snapshot[index].basePlace;
  }

  Widget buildList(snapshot) {
    return GridView.count(
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
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CardModal(
                        cardTitle: titleCheck(snapshot, index),
                        card: snapshot[index]),
                  );
                },
                child: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.white60, width: 4),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    snapshot[index].cardImageUrl))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(titleCheck(snapshot, index),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 11)),
                      ),
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }
}
