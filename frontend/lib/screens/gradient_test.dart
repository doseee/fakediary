import 'package:flutter/material.dart';

class GradientTest extends StatelessWidget {
  const GradientTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0a609c),
              Color(0xFFe38b8b),
            ],
          ),
        ),
        child: const Text('hi'),
      ),
    );
  }
}
