import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModifyScreen extends StatefulWidget {
  const ModifyScreen({super.key});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController basenameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadNickname();
  }

  Future<void> loadNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nickname = prefs.getString('nickname') ?? '';
    setState(() {
      nicknameController.text = nickname;
    });
  }

  Future<void> loadBasename() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String basename = prefs.getString('diaryBaseName') ?? '';
    setState(() {
      basenameController.text = basename;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
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
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image(
                    image: AssetImage('assets/img/silver_moon.png'),
                  ),
                  Row(
                    children: [
                      Text(
                        '닉네임',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: nicknameController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    maxLength: 10,
                    decoration: const InputDecoration(
                        counterStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        hintText: '닉네임을 입력하세요.',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                  Row(
                    children: [
                      Text(
                        '일기 자동생성시간',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
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
                        width: 70,
                        child: CupertinoPicker(
                          itemExtent: 32.0, // 각 항목의 높이를 지정합니다.
                          onSelectedItemChanged: (int index) {
                            // 선택된 항목이 변경될 때마다 호출되는 콜백입니다.
                            // 이곳에서 선택된 값을 처리하면 됩니다.
                          },
                          children: List<Widget>.generate(24, (int index) {
                            return Center(
                              child: Text(
                                index.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ), // 숫자를 표시하는 텍스트 위젯을 생성합니다.
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: CupertinoPicker(
                          backgroundColor: Colors.transparent,
                          itemExtent: 32.0, // 각 항목의 높이를 지정합니다.
                          onSelectedItemChanged: (int index) {
                            // 선택된 항목이 변경될 때마다 호출되는 콜백입니다.
                            // 이곳에서 선택된 값을 처리하면 됩니다.
                          },
                          children: List<Widget>.generate(60, (
                            int index,
                          ) {
                            return Center(
                              child: Text(
                                index.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ), // 숫자를 표시하는 텍스트 위젯을 생성합니다.
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: CupertinoPicker(
                          itemExtent: 32.0, // 각 항목의 높이를 지정합니다.
                          onSelectedItemChanged: (int index) {
                            // 선택된 항목이 변경될 때마다 호출되는 콜백입니다.
                            // 이곳에서 선택된 값을 처리하면 됩니다.
                          },
                          children: List<Widget>.generate(60, (int index) {
                            return Center(
                              child: Text(
                                index.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ), // 숫자를 표시하는 텍스트 위젯을 생성합니다.
                            );
                          }),
                        ),
                      ),
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
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: basenameController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    maxLength: 10,
                    decoration: const InputDecoration(
                        counterStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        hintText: '기본 주인공 이름을 입력하세요.',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 267,
                      height: 60,
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
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '설정',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
