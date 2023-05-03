import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/services/api_service.dart';
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
            image: AssetImage('assets/img/background_pink_darken.png'),
            fit: BoxFit.cover,
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
                      SizedBox(
                        width: 70,
                        child: CupertinoPicker(
                          scrollController: minuteController,
                          backgroundColor: Colors.transparent,
                          itemExtent: 32.0,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              minute = index.toString().padLeft(2, '0');
                            });
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
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: CupertinoPicker(
                          scrollController: secondController,
                          itemExtent: 32.0,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              second = index.toString().padLeft(2, '0');
                            });
                          },
                          children: List<Widget>.generate(60, (int index) {
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
                    onTap: () {
                      ApiService.modifyUser(nicknameController.text, hour,
                          minute, second, basenameController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
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
