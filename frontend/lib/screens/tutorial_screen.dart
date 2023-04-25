import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0F2027),
            Color(0xff203A43),
            Color(0xff2C5364),
          ],
          stops: [0, 0.4, 1.0],
        ),
        image: DecorationImage(
          image: AssetImage('assets/img/bg_galaxy.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image(
            image: AssetImage('assets/img/tutorial_cards.png'),
          ),
        ),
      ),
    );
  }
}
