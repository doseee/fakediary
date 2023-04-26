import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Image(
        image: AssetImage(
          'assets/img/icon_cam.png',
        ),
      ),
    );
  }
}
