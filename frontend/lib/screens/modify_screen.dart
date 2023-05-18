import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/login_entrance.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';
import 'home_circlemenu.dart';

class ModifyScreen extends StatefulWidget {
  const ModifyScreen({super.key});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController basenameController = TextEditingController();
  String hour = '00';
  String minute = '00';
  String second = '00';
  int intHour = 0;
  int intMinute = 0;
  int intSecond = 0;

  FixedExtentScrollController hourController = FixedExtentScrollController();
  FixedExtentScrollController minuteController = FixedExtentScrollController();
  FixedExtentScrollController secondController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    hour = prefs.getInt('hour').toString().padLeft(2, '0');
    minute = prefs.getInt('minute').toString().padLeft(2, '0');
    second = prefs.getInt('second').toString().padLeft(2, '0');
    intHour = prefs.getInt('hour') ?? 0;
    intMinute = prefs.getInt('minute') ?? 0;
    intSecond = prefs.getInt('second') ?? 0;
    String nickname = prefs.getString('nickname') ?? '';
    nicknameController.text = nickname;
    String basename = prefs.getString('diaryBaseName') ?? '';
    basenameController.text = basename;
    print(intSecond);
    hourController.jumpToItem(intHour);
    minuteController.jumpToItem(intMinute);
    secondController.jumpToItem(intSecond);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background_1_darken.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
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
                Text('마이페이지',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                Lottie.asset('assets/lottie/menu_grinstar.json', width: 30),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final pref = await SharedPreferences.getInstance();
                        pref.setBool('isLogged', false);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginEntrance()));
                      },
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BtnThemeGradientLine(),
                        child: const Center(
                          child: Text(
                            '로그아웃',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset('assets/lottie/friend_planet.json',
                          width: 100, height: 100),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '닉네임',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      TextField(
                        controller: nicknameController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'[!@#$%^&*(),.?":{}|<>;]')),
                        ],
                        maxLength: 10,
                        decoration: const InputDecoration(
                            counterStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                            ),
                            hintText: '닉네임을 입력하세요.',
                            hintStyle: TextStyle(
                              color: Colors.blue,
                            )),
                      ),
                      Row(
                        children: [
                          Text(
                            '일기 자동 생성 시간',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CupertinoPicker(
                              scrollController: hourController,
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  hour = index.toString().padLeft(2, '0');
                                });
                              },
                              children: List<Widget>.generate(24, (int index) {
                                return Center(
                                  child: Text(
                                    index.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Text(
                            '시',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CupertinoPicker(
                              scrollController: minuteController,
                              backgroundColor: Colors.transparent,
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  minute =
                                      (index * 30).toString().padLeft(2, '0');
                                });
                              },
                              children: List<Widget>.generate(2, (
                                int index,
                              ) {
                                return Center(
                                  child: Text(
                                    (index * 30).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Text(
                            '분',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          // SizedBox(
                          //   width: 70,
                          //   child: CupertinoPicker(
                          //     scrollController: secondController,
                          //     itemExtent: 32.0,
                          //     onSelectedItemChanged: (int index) {
                          //       setState(() {
                          //         second = index.toString().padLeft(2, '0');
                          //       });
                          //     },
                          //     children: List<Widget>.generate(60, (int index) {
                          //       return Center(
                          //         child: Text(
                          //           index.toString(),
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       );
                          //     }),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          Text(
                            '기본 주인공 이름',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      TextField(
                        controller: basenameController,
                        style: TextStyle(
                          color: Colors.blue[100],
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                        ],
                        maxLength: 10,
                        decoration: const InputDecoration(
                            counterStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                            ),
                            hintText: '기본 주인공 이름을 입력하세요.',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final result = await ApiService.modifyUser(
                                nicknameController.text,
                                hour,
                                minute,
                                second,
                                basenameController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                            if (result == true) {
                              Flushbar(
                                message: '수정 성공!',
                                flushbarPosition: FlushbarPosition.TOP,
                                duration: Duration(seconds: 2),
                              ).show(context);
                            }
                          },
                          child: Container(
                            width: 170,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xff263344),
                                  const Color(0xff1B2532).withOpacity(0.53),
                                  const Color(0xff1C2A3D).withOpacity(0.5),
                                  const Color(0xff1E2E42).withOpacity(0.46),
                                  const Color(0xff364B66).withOpacity(0.33),
                                  const Color(0xff2471D6).withOpacity(0),
                                ],
                                stops: const [0, 0.25, 0.4, 0.5, 0.75, 1.0],
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff000000).withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                '저장하기',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: 90 * 3.1415926535 / 180,
                        child: Lottie.asset(
                          'assets/lottie/star-twinkle.json',
                          height: 88,
                          width: 88,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
