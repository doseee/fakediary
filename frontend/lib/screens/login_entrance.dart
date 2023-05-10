import 'package:flutter/material.dart';
import 'package:frontend/screens/regist_screen.dart';
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
                  flex: 4,
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
                                        style: TextStyle(color: Colors.white, fontSize: 16,),
                                      )),
                                ),
                              )),
                        ),
                      ],
                    )
                  )),
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
                        child:GestureDetector(
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
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    )),
                              ),
                            )),
                      ),
                    ],
                  ))
            ],
          ))),
    );
  }
}
