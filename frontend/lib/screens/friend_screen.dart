import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/screens/menu_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/info_modal.dart';
import 'package:frontend/widgets/theme.dart';

class FriendScreen extends StatefulWidget {
  final int diaryId;
  final int exchangeSituation;

  const FriendScreen(
      {Key? key, required this.diaryId, required this.exchangeSituation})
      : super(key: key);

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  Widget ChangeModal(int diaryId) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              '랜덤 교환하시겠습니까?',
              style: TextStyle(fontSize: 16, color: Colors.white60),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            decoration: BtnThemeGradientLine(),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                onPressed: () async {
                  bool result = await ApiService.RandomChange(widget.diaryId);
                  if (!mounted) return;
                  if (result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiaryListScreen()));
                  }
                },
                child: Center(
                  child: Text('신청'),
                )),
          ),
        )
      ],
    );
  }

  Widget RandomDiary(){
    if(widget.exchangeSituation == 1){
      return SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          print('friend details');
                        },
                        child: Text(
                          'RANDOM',
                          style: TextStyle(
                              fontSize: 24, color: Colors.white70),
                        )),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(),
              ),
              Flexible(
                flex: 3,
                child: Center(
                  child: Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xff79F1A4),
                          Color(0xff0E5CAD),
                        ]),
                        borderRadius: BorderRadius.circular(25)),
                    child: ElevatedButton(
                        onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const Login(),
                          //     ));
                          print(widget.diaryId);
                          //Todo; api 먼저 보내서 오늘 랜덤 일기 교환했는지 여부 확인 후 다른 상태 Modal 띄우기
                          showDialog(
                              context: context,
                              builder: (context) {
                                return InfoModal(
                                  widget: ChangeModal(widget.diaryId),
                                  height: 180,
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30.0),
                            )),
                        child: Text(
                          'SEND',
                          style: TextStyle(
                              color: Colors.white, fontSize: 14),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(height: 5,);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff0F2027), Color(0xff203A43), Color(0xff2C5364)],
          stops: [0.2, 0.7, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1183,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(6.0),
            child: Container(
              color: Colors.white70,
              height: 1.0,
            ),
          ),
          title: Text('FRIENDS'),
          actions: [
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
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Go frined add page');
                    },
                    child: Image(
                      image: AssetImage(
                        'assets/img/friend_icon.png',
                      ),
                      width: 45,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text('이름을 누르면 친구와 교환한 일기를 볼 수 있습니다.', style: TextStyle(color: Colors.white70, fontSize: 12),),
                // ),
                RandomDiary(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
