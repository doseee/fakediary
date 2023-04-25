import 'package:flutter/material.dart';
import 'package:frontend/screens/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/main_background.jpg'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1183,
            actions: const [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                          image: AssetImage('assets/img/icon_alarm.png'),
                          width: 50, // set the desired width
                          height: 50, // set the desired height
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Container(
              child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            },
            icon: Image.asset(
              'assets/img/icon_menu.png',
              width: 80,
              height: 80,
            ),
          )),
        ));
  }
}
