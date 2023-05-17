import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/screens/tutorial_screen.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Widget _userIdWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: '이메일을 입력하세요',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '이메일을 입력하세요';
        } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$').hasMatch(value)) {
          return '유효한 이메일 주소를 입력하세요';
        }
        return null;
      },
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: '비밀번호를 입력하세요',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '비밀번호가 공백입니다';
        }
        return null;
      },
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buttonLogin() {
    return GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            print(_emailController.text);
            print(_passwordController.text);
            final bool result = await ApiService.login(
                _emailController.text, _passwordController.text);
            if (!mounted) return;
            final pref = await SharedPreferences.getInstance();
            final isFirstLaunch = pref.getBool('isFirstLaunch') ?? true;
            if (isFirstLaunch) {
              pref.setBool('isFirstLaunch', false);
            }
            if (result) {
              FocusScope.of(context).unfocus();
              if (isFirstLaunch) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TutorialScreen()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                      settings: RouteSettings(name: 'Login'),
                    ));
              }
              Flushbar(
                      message: "로그인 성공!",
                      duration: Duration(seconds: 3),
                      flushbarPosition: FlushbarPosition.TOP)
                  .show(context);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Center(child: Text('login success!')),
              //   ),
              // );
            } else {
              ScaffoldMessenger.of(context).showMaterialBanner(
                MaterialBanner(
                  backgroundColor: Colors.grey.shade800,
                  content: Text('입력를 확인해주세요.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                      child: Text('닫기'),
                    ),
                  ],
                ),
              );
              Future.delayed(Duration(seconds: 3), () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              });
            }
          }
        },
        child: Center(
          child: Container(
            width: 250,
            height: 50,
            decoration: BtnThemeGradient(),
            child: Center(
                child: Text(
              '로그인',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          ),
        ));
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
                image: AssetImage('assets/img/background_1_littledark.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(top: 60, right: 70, left: 70),
                      child: Column(children: [
                        Center(
                          child: Lottie.asset('assets/lottie/stars.json'),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _userIdWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            _passwordWidget(),
                            SizedBox(
                              height: 40,
                            ),
                            _buttonLogin(),
                            // SizedBox(
                            //   height: 280,
                            // ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Text(
                          'My Lieary',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ]),
                    )))));
  }
}
