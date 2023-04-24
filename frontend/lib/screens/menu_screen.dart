import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
        body: Stack(
          children: const [
            Flexible(
              flex: 100,
              child: Text(
                'top12',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Flexible(
              flex: 427,
              child: Text(
                'top',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Flexible(
              flex: 318,
              child: Text(
                'top',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
