import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/model/CardModel.dart';
import 'package:frontend/screens/card_create.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/services/api_service.dart';
import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/card_modal.dart';
import '../widgets/theme.dart';
import '../widgets/appbar.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
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

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/background_pink_darken.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(6.0),
            child: Container(
              color: Colors.white70,
            ),
          ),
          title: Row(
            children: [
              Text('내 카드' , style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700)),
              Lottie.asset('assets/lottie/menu_grinstar.json',
                  width: 30),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CardCreate()));
                    },
                    child: Container(
                      width: 85,
                      height: 42,
                      decoration: BtnThemeGradientLine(),
                      child: Center(
                          child: Text(
                            '카드 만들기',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Image(
                      image: AssetImage(
                        'assets/img/home_icon.png',
                      ),
                      width: 45,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Lottie.asset('assets/lottie/2-tarot.json',
                                height: 100),
                          ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          Text('내가 만든 카드를 확인해보세요',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white)),
                          Text('카드를 누르면 해당 카드의 상세 정보를 확인할 수 있습니다',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white54)),
                          // SizedBox(
                          //   height: 10,
                          // ),
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
                  flex: 10,
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
            ],
          ),
        ),
      ),
    ));
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
      childAspectRatio: 0.66,
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
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            border: Border.all(color: Colors.white, width: 2),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    snapshot[index].cardImageUrl))),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(titleCheck(snapshot, index),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 10)),
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
