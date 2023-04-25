import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardCreate extends StatefulWidget {
  const CardCreate({super.key});

  @override
  _CardCreateState createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/main_background.jpg'),
          ),
        ),
        child: Container(
          child: Lottie.asset('assets/lottie/camera_loop.json', width: 10),
        ));
  }
}
