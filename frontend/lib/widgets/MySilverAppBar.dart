import 'package:flutter/material.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final List<String> subtitles;
  final int currentIndex;

  MySliverAppBar(
      {required this.expandedHeight,
      required this.subtitles,
      required this.currentIndex});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: expandedHeight,
      child: Center(
        child: Text(
          subtitles[currentIndex],
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant MySliverAppBar oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight ||
        subtitles != oldDelegate.subtitles ||
        currentIndex != oldDelegate.currentIndex;
  }
}
