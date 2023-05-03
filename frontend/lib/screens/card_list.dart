import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/model/CardModel.dart';
import 'package:frontend/screens/menu_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/bg_theme.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class CardModal extends StatelessWidget {
  //모달창 class
  final int cardIndex;
  final String cardTitle;

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
            title: Text(cardTitle,
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
  late Future<List<CardModel>> cards;
  late Future<int> lengthOfCards;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cards = ApiService().getCardList();
    print(cards);
  }
  Widget build(BuildContext context) {
    return (Container(
        decoration: BgThemeGradient(),
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
                      flex: 5,
                      child: FutureBuilder<List<CardModel>>(
                        future: cards,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return buildList(snapshot.data);
                          } else if (snapshot.hasError){
                            return Text("${snapshot.error}에러!!");
                          }
                          return CircularProgressIndicator();
                        }
                      )
                  ),
                ])))));
  }

  String titleCheck(snapshot, index){
    if (snapshot[index].keywords.length != 0){
      return snapshot[index].keywords[0];
    } else if (snapshot[index].baseName != ''){
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
          if(snapshot.length == 0){
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
                        cardIndex: index, cardTitle: titleCheck(snapshot, index)),
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
                                    snapshot[index].cardImageUrl
                                )
                            )
                        ),
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