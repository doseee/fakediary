import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/screens/tutorial_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/theme.dart';
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
  final TextEditingController _nicknameController = TextEditingController();

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
                  padding: EdgeInsets.only(right: 70, left: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/stars.json'),
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
                          String pattern = r'@#%*(){}&^[\w-]+$?!_=|\/,.';
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
                      GestureDetector(
                        onTap: () async {
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
                            final pref = await SharedPreferences.getInstance();
                            final isFirstLaunch =
                                pref.getBool('isFirstLaunch') ?? true;
                            if (isFirstLaunch) {
                              pref.setBool('isFirstLaunch', false);
                            }
                            if (result) {
                              if (isFirstLaunch) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TutorialScreen()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                      settings: RouteSettings(name: 'Login'),
                                    ));
                              }
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content:
                              //         Center(child: Text('login success!')),
                              //   ),
                              // );
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
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text('duplicate information.'),
                              //   ),
                              // );
                            }
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
