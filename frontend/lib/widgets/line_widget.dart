import 'package:flutter/material.dart';

class LineWidget extends StatefulWidget {
  const LineWidget({Key? key}) : super(key: key);

  @override
  _LineWidgetState createState() => _LineWidgetState();
}

class _LineWidgetState extends State<LineWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // define the animation tween
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomPaint(
            painter: _SearchAnimationPainter(_animation.value),
            child: child,
          ),
        );
      },
      child: Center(),
    );
  }
}

class _SearchAnimationPainter extends CustomPainter {
  final double animationValue;

  _SearchAnimationPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // calculate the center of the screen
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // calculate the length of the lines
    final lineLength = size.width / 2 * animationValue;

    // define the paint style
    final Paint paint = Paint()
      ..color = Color(0xff638A9B)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // draw the lines
    canvas.drawLine(
      Offset(centerX - lineLength, centerY),
      Offset(centerX + lineLength, centerY),
      paint,
    );
  }

  @override
  bool shouldRepaint(_SearchAnimationPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
