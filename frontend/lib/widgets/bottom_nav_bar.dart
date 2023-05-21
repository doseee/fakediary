import 'dart:core';

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: ImageIcon(AssetImage('assets/img/small_moon.png')),
          label: '카드',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: Icon(Icons.add_photo_alternate_outlined),
          label: '일기',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: Icon(Icons.book),
          label: '친구',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: Icon(Icons.person),
          label: '마이페이지',
        ),
      ],
    );
  }
}
