import 'package:flutter/material.dart';

import '../screens/menu_screen.dart';

AppBar StandAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: MediaQuery.of(context).size.height * 0.1183,
    actions: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuScreen()));
                  },
                  child: Image(
                    image: AssetImage(
                      'assets/img/icon_menu_page.png',
                    ),
                    width: 45,
                  ),
                ),
              ],
            ),
          )
        ],
      )
    ],
  );
}