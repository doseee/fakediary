import 'package:flutter/material.dart';
import 'package:frontend/screens/regist_screen.dart';
import 'package:lottie/lottie.dart';

import 'login.dart';
import 'menu_screen.dart';

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
          image: AssetImage('assets/img/bg_galaxy.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1183,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenuScreen(),
                              ),
                            );
                          },
                          icon: Image.asset('assets/img/icon_menu_page.png'),
                          iconSize: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]
          ),
          body: Center(
            child: Column(
              children: [
                Flexible(flex: 3,
                  child:
                  Center(
                    child: Text('My Lieary', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Color(0xfff1f1f1)),
                ),),),
              Flexible(flex: 4, child: Container(
                child: Lottie.asset('assets/lottie/login_ent.json', width: 300),
              )),
              Padding(padding: EdgeInsets.only(left: 50, right: 50),
                child:
                Flexible(flex: 1, child: ElevatedButton(
                  onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child:
                        Text('LOGIN', style: TextStyle(color: Colors.black, fontSize: 14),)
                  )
                ),),),
                Padding(padding: EdgeInsets.only(left: 50, right: 50),
                  child:
                  Flexible(flex: 1, child: ElevatedButton(
                      onPressed: () { print('join'); },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4b6858),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                          child: Text(
                            'JOIN',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ))),
                ),
              ),
              Flexible(flex: 2, child: Container()),
            ],
          ))),
    );
  }
}
