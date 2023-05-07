import 'package:flutter/material.dart';

class DiaryDetailAnimatedText extends StatefulWidget {
  final String text;

  const DiaryDetailAnimatedText({Key? key, required this.text}) : super(key: key);

  @override
  _DiaryDetailAnimatedTextState createState() => _DiaryDetailAnimatedTextState();
}

class _DiaryDetailAnimatedTextState extends State<DiaryDetailAnimatedText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0), //fade out the last 20% of the animation
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Text(widget.text, style: const TextStyle(color: Colors.white70, fontSize: 25, fontWeight: FontWeight.w800),),
        );
      },
    );
  }
}