import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/diary_detail_animated_text.dart';
import 'package:frontend/screens/diary_detail_screen.dart';

class DiaryDetailCoverScreen extends StatefulWidget {
  final int diaryId;
  final int exchangeSituation;
  final String imageUrl;// 내 일기는 1 0r 2로 넘어오고 친구가 보낸 일기는 3으로 넘길 것

  const DiaryDetailCoverScreen({Key? key, required this.diaryId, required this.exchangeSituation, required this.imageUrl})
      : super(key: key);

  @override
  State<DiaryDetailCoverScreen> createState() => _DiaryDetailCoverScreenState();
}

class _DiaryDetailCoverScreenState extends State<DiaryDetailCoverScreen>
    with SingleTickerProviderStateMixin {
  bool _showCover = true;
  late AnimationController _controller;
  late Animation<Offset> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(
        reverse:
        true); // repeat the animation continuously, reversing at the end
    _iconAnimation = TweenSequence([
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
          begin: Offset(0, 0),
          end: Offset(0, -0.2),
        ),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
          begin: Offset(0, -0.2),
          end: Offset(0, 0),
        ),
        weight: 1,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _showCover = false;
          }
          );
          _controller.forward();
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => DiaryDetailScreen(diaryId: widget.diaryId, exchangeSituation: widget.exchangeSituation,),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 750), // updated value
            ),
          );

        },
        child: Stack(
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: _showCover ? 1.0 : 0.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage( widget.imageUrl ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: DiaryDetailAnimatedText(
                    text: '위로 쓸어 올려 보세요',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 32.0,
              left: 0.0,
              right: 0.0,
              child: SlideTransition(
                position: _iconAnimation,
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  size: 80.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
