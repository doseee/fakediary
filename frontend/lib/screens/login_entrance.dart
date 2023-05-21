import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/regist_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:lottie/lottie.dart';

import '../widgets/theme.dart';
import 'login.dart';

class LoginEntrance extends StatefulWidget {
  const LoginEntrance({Key? key}) : super(key: key);

  @override
  State<LoginEntrance> createState() => _LoginEntranceState();
}

class _LoginEntranceState extends State<LoginEntrance>
    with SingleTickerProviderStateMixin {
  void loginKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          // '\n이메일: ${user.kakaoAccount?.email}'
          );
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/background_1_littledark.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1183,
          ),
          body: Center(
              child: Column(
            children: [
              Flexible(flex: 1, child: Container()),
              Flexible(
                  flex: 5,
                  child: Container(
                    child: Lottie.asset('assets/lottie/login_ent.json',
                        width: 300),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: Container(
                      width: 250,
                      height: 50,
                      decoration: BtnThemeGradient(),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ));
                                },
                                child: Center(
                                  child: Container(
                                    width: 250,
                                    height: 50,
                                    decoration: BtnThemeGradient(),
                                    child: Center(
                                        child: Text(
                                      '로그인',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )),
                                  ),
                                )),
                          ),
                        ],
                      ))),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 250,
                  height: 50,
                  decoration: BtnThemeGradientLine(),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegistScreen(),
                                  ));
                            },
                            child: Center(
                              child: Container(
                                width: 250,
                                height: 50,
                                decoration: BtnThemeGradientLine(),
                                child: Center(
                                    child: Text(
                                  '회원이 아니신가요? JOIN',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                              ),
                            )),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  loginKakao();
                },
                child: Center(
                    child: Image.asset(
                  'assets/img/kakao_login.png',
                )),
              )
            ],
          ))),
    );
  }
}
