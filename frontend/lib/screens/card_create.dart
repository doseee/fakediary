import 'package:flutter/material.dart';
import 'package:frontend/camera_ex.dart';
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
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.3,
            0.6,
            0.9
          ],
              colors: [
            Color(0xff0f2027),
            Color(0xff203a43),
            Color(0xff2c5364),
          ])),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CameraExample()));
        },
        child: Lottie.asset(
          'assets/lottie/camera_loop.json',
          width: 80,
          height: 80,
        ),

        // Positioned(
        //   top: 0,
        //   right: -40,
        //   child: SizedBox(
        //     width: 180,
        //     height: 180,
        //     child: Lottie.asset('assets/lottie/camera_loop.json'),
        //   ),
        // ),
      ),
    );
  }
}
