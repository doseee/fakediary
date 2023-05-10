import 'package:flutter/material.dart';
import 'package:frontend/model/FriendModel.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/screens/friend_searchnew.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/info_modal.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_circlemenu.dart';

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
  late Future<List<FriendModel>> friends;
  int recieverId = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friends = ApiService().getFriends();
  }

  Widget ChangeModal(int diaryId) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              '교환하시겠습니까?',
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
                  late bool result;

                  if (recieverId == -1) {
                    result = await ApiService.RandomChange(widget.diaryId);
                  } else {
                    print('recieverId : $recieverId');
                    result = await ApiService.DiaryChangeBetweenFriends(
                        widget.diaryId, recieverId);
                    print('friend diary change: ${widget.diaryId}');
                  }

                  if (!mounted) return;
                  if (result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiaryListScreen()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text('교환 일기신청을 완료했습니다!')),
                      ),
                    );
                  } else {
                    print('전송 실패');
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

  Widget GoSelectDiary() {
    if (widget.exchangeSituation == 1) { return Container(); } else {
      return Column(
        children: [ GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DiaryListScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Text(
              '일기 교환하러 가기   >',
              style: TextStyle(
                  color: Colors.blue[100],
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
            ),
          ),
        ),
          Container(height: 0.3, color: Colors.white),
        ],
      );
    }
  }

  Widget RandomDiary() {
    if (widget.exchangeSituation == 1) {
      return SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Flexible(
                  flex: 4,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: Text(
                          'RANDOM',
                          style: TextStyle(fontSize: 24, color: Colors.white70),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: IconButton(
                              icon: Icon(Icons.info, color: Colors.white),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return InfoModal(
                                          padding: 20,
                                          color: true,
                                          widget: Text(
                                            '✉ 랜덤 일기는 랜덤 친구와 일기를 교환할 수 있는 기능으로, 하루에 한 번만 보낼 수 있습니다.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                          height: 100);
                                    });
                              }),
                        ),
                      )
                    ],
                  )),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Flexible(
                flex: 3,
                child: Center(
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BtnThemeGradient(),
                    child: ElevatedButton(
                        onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const Login(),
                          //     ));
                          print(widget.diaryId);
                          //Todo; api 먼저 보내서 오늘 랜덤 일기 교환했는지 여부 확인 후 다른 상태 Modal 띄우기
                          final bool result = await ApiService.CheckChange();

                          if (!mounted) return;

                          print(result);
                          if (result) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return InfoModal(
                                    padding: 20,
                                    color: true,
                                    widget: Text(
                                      '오늘은 이미 교환일기를 보냈습니다',
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    height: 140,
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return InfoModal(
                                    padding: 20,
                                    color: true,
                                    widget: ChangeModal(widget.diaryId),
                                    height: 180,
                                  );
                                });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        child: Text(
                          'SEND',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: 5,
    );
  }

  Widget ChangeCheck(FriendModel friend) {
    if (widget.exchangeSituation == 1) {
      return Flexible(
          flex: 2,
          child: Container(
            width: 250,
            height: 50,
            decoration: BtnThemeGradientLine(),
            child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    recieverId = friend.friendId;
                  });
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const Login(),
                  //     ));
                  showDialog(
                      context: context,
                      builder: (context) {
                        return InfoModal(
                          padding: 20,
                          color: true,
                          widget: ChangeModal(widget.diaryId),
                          height: 180,
                        );
                      });

                  print('친구 : ${friend.friendId}');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                child: Text(
                  'SEND',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )),
          ));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/background_pink_darken.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: MediaQuery
              .of(context)
              .size
              .height * 0.1183,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(6.0),
            child: Container(
              color: Colors.white70,
              height: 0.5,
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
                              builder: (context) => HomeScreen()));
                    },
                    child: Image(
                      image: AssetImage(
                        'assets/img/home_icon.png',
                      ),
                      width: 45,
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
                              builder: (context) => SearchScreen()));
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
          child: Column(
            children: [
              GoSelectDiary(),
              Container(height: 0.3, color: Colors.white),
              RandomDiary(),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 5),
                    child: FutureBuilder<List<FriendModel>>(
                        future: friends,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final friend = snapshot.data![index];
                                  return Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: SvgPicture.asset(
                                            'assets/svg/atronaut-svgrepo-com.svg',
                                            semanticsLabel: 'user',
                                            width: 50,
                                            height: 50,
                                          ),
                                          title: Row(children: [
                                            Flexible(
                                                flex: 3,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        friend.nickname,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white70,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 19),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            ChangeCheck(friend),
                                          ]),
                                        ),
                                        Container(
                                          height: 0.1,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            print('error : ${snapshot.error}');
                          }

                          return Center(
                            child: Text(
                              '새로운 친구를 만들어보세요!',
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
