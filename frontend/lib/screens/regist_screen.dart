import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/screens/law_form.dart';
import 'package:frontend/screens/law_info_form.dart';
import 'package:frontend/screens/tutorial_one.dart';
import 'package:frontend/screens/tutorial_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistScreen extends StatefulWidget {
  const RegistScreen({super.key});

  @override
  State<RegistScreen> createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  bool agreeSelected = false;
  bool infoAgreeSelected = false;

  setAgree() {
    setState(() {
      agreeSelected = !agreeSelected;
    });
  }
  setInfoAgree() {
    setState(() {
      infoAgreeSelected = !infoAgreeSelected;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background_1_littledark.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 150.0,
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(right: 60, left: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Center(child: Lottie.asset('assets/lottie/stars.json',width: 100)),
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: '이메일을 입력하세요.',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        validator: (String? value) {
                          // Email 형식 유효성 검사를 위한 정규식
                          String pattern =
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                          RegExp regExp = RegExp(pattern);

                          if (value == null || value.isEmpty) {
                            return '이메일이 공백입니다';
                          } else if (!regExp.hasMatch(value)) {
                            // 정규식에 맞지 않을 경우
                            return '유효한 이메일을 입력해주세요';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: '비밀번호를 입력하세요.',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호가 공백입니다.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // New confirm password TextFormField
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: '비밀번호를 다시 입력하세요.',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호 확인란이 공백입니다.';
                          } else if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            return '비밀번호가 일치하지 않습니다.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _nicknameController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                            ),
                            labelText: 'Nickname',
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: '닉네임을 입력하세요.',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        validator: (String? value) {
                          // 특수문자를 포함하지 않는 정규식
                          String pattern = r'^[a-zA-Z0-9_\uAC00-\uD7A3-]+$';
                          RegExp regExp = RegExp(pattern);

                          if (value == null || value.isEmpty) {
                            return '닉네임이 공백입니다.';
                          } else if (!regExp.hasMatch(value)) {
                            // 정규식에 맞지 않을 경우
                            return '닉네임에 특수문자를 사용할 수 없습니다.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setAgree();
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 17,
                                  height: 17,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: GradientBoxBorder(
                                        gradient: LinearGradient(stops: [
                                      0,
                                      1.0
                                    ], colors: [
                                      Color(0xff65D5A6),
                                      Color(0xff1E72AC),
                                    ])),
                                    gradient: agreeSelected
                                        ? LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [0, 1.0],
                                            colors: [
                                              Color(0xff65D5A6),
                                              Color(0xff1E72AC),
                                            ],
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '이용약관에 동의하기 (필수)',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LawForm()));
                            },
                            child: Text(
                              '보기',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setInfoAgree();
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 17,
                                  height: 17,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: GradientBoxBorder(
                                        gradient: LinearGradient(stops: [
                                      0,
                                      1.0
                                    ], colors: [
                                      Color(0xff65D5A6),
                                      Color(0xff1E72AC),
                                    ])),
                                    gradient: infoAgreeSelected
                                        ? LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [0, 1.0],
                                            colors: [
                                              Color(0xff65D5A6),
                                              Color(0xff1E72AC),
                                            ],
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '개인정보 수집 및 이용동의 (필수)',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LawInfoForm()));
                            },
                            child: Text(
                              '보기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                decoration: TextDecoration.underline
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (agreeSelected && infoAgreeSelected) {
                            if (_formKey.currentState!.validate()) {
                              print(_emailController.text);
                              print(_nicknameController.text);
                              print(_passwordController.text);
                              final bool result = await ApiService.signup(
                                _emailController.text,
                                _nicknameController.text,
                                _passwordController.text,
                              );
                              if (!mounted) return;
                              final pref =
                                  await SharedPreferences.getInstance();
                              final isFirstLaunch =
                                  pref.getBool('isFirstLaunch') ?? true;
                              if (isFirstLaunch) {
                                pref.setBool('isFirstLaunch', false);
                              }
                              if (result) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TutorialOne()));
                                Flushbar(
                                  message: "회원가입 성공!",
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.greenAccent,
                                  flushbarPosition: FlushbarPosition.TOP,
                                ).show(context);
                              } else {
                                Flushbar(
                                  message: "회원가입 실패!(이메일 또는 닉네임이 중복되었습니다.)",
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.redAccent,
                                  flushbarPosition: FlushbarPosition.TOP,
                                ).show(context);
                              }
                            }
                          } else {
                            Flushbar(
                              message: "이용약관 및 정보수집에 동의해주세요",
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.redAccent,
                              flushbarPosition: FlushbarPosition.TOP,
                            ).show(context);
                          }
                        },
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: BtnThemeGradient(),
                          child: Center(
                              child: Text(
                            '회원가입',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                        ),
                      )
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
