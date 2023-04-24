import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/bg_galaxy.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: const [
            Flexible(
              flex: 100,
              child: Text('top12'),
            ),
            Flexible(
              flex: 427,
              child: Text('top'),
            ),
            Flexible(
              flex: 318,
              child: Text('top'),
            ),
          ],
        ),
      ),
    );
  }
}
