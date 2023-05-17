import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/info_modal.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../model/CardModel.dart';
import '../screens/diary_create_cards.dart';

class CardModal extends StatelessWidget {
  //모달창 class
  final CardModel card;
  final String cardTitle;

  const CardModal({Key? key, required this.card, required this.cardTitle})
      : super(key: key);

  Widget Character() {
    if (card.baseName == '') {
      return  Flexible(
          flex: 1,
          child: Center(
            child: Row(
              children: [
                Text(
                  '주인공 : ',
                  style: TextStyle(color: Colors.white,fontSize: 13),
                ),
                Text('선택 안함', style: TextStyle(color: Colors.white54)),
              ],
            ),
          ));
    } else {
      return Flexible(
          flex: 1,
          child: Center(
            child: Row(
              children: [
                Text(
                  '주인공 : ',
                  style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w700),
                ),
                Text(card.baseName, style: TextStyle(color: Colors.white)),
              ],
            ),
          ));
    }
  }

  Widget Place() {
    if (card.basePlace == '') {
      return Flexible(
        flex: 1,
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '장소 :',
              style: TextStyle(color: Colors.white,fontSize: 13),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child:
              Text('선택 안함', style: TextStyle(color: Colors.white54)),
            )
          ],
        ),
      );
    } else {
      return Flexible(
          flex: 1,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '장소 :',
                style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child:
                    Text(card.basePlace, style: TextStyle(color: Colors.white,fontSize: 13)),
              )
            ],
          ));
    }
  }

  Widget Kewyords() {
    if (card.keywords.isEmpty) {
      return Container();
    } else {
      String keywords = card.keywords.join(', ');
      return Flexible(
          flex: 3,
          child: Center(
              child: Column(
            children: [
              Flexible(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        decoration: BtnThemeGradientLine(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Text(
                            '키워드',
                            style: TextStyle(color: Colors.white ,fontSize: 13,fontWeight: FontWeight.w700),
                          ),
                        )),
                  )),
              Flexible(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:
                        Text(keywords, style: TextStyle(color: Colors.white)),
                  ))
            ],
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    print('cardId : ${card.cardId}');
    print('here???');
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
              padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
              child: Column(
                children: [

                  Flexible(
                    flex: 1,
                    child: Text(
                      '기억의 조각이 완성된 날',
                      style: TextStyle(color: Colors.white,fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      card.createdAt.split('T')[0],
                      style: TextStyle(color: Colors.white,fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('카드를 터치해서 크게보세요' ,style:TextStyle(fontSize: 11,color: Colors.white54) ),
                  Flexible(
                    flex: 10,
                    child: Center(
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return InfoModal(
                                          padding: 0,
                                          color: false,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          widget: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        card.cardImageUrl),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3.5,
                                  height:
                                      (MediaQuery.of(context).size.width / 3.0) *
                                          1.35,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                        image: NetworkImage(card.cardImageUrl),
                                        ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: 300,
                                height: 240,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 20, 0, 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var file = card.cardImageUrl;
                                  final result = await GallerySaver.saveImage(file);
                                  if (result != null) {
                                    Flushbar(
                                            message: "사진 저장 성공!",
                                            duration: Duration(seconds: 3),
                                            flushbarPosition: FlushbarPosition.TOP)
                                        .show(context);
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Center(child: Text('사진 저장 성공!')),
                                    //   ),
                                    // );
                                  } else {
                                    Flushbar(
                                            message: "권한을 허용해주세요.",
                                            duration: Duration(seconds: 3),
                                            flushbarPosition: FlushbarPosition.TOP)
                                        .show(context);
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Center(child: Text('권한을 허용해주세요.')),
                                    //   ),
                                    // );
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xff79F1A4),
                                        Color(0xff0E5CAD),
                                      ]),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: Text(
                                    '사진저장',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              )
                              ,
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DiaryCreateCards(
                                            cardIdFromList: card.cardId),
                                      ));
                                  print(card.cardId);
                                },
                                child: Container(
                                  width: 100,
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
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
