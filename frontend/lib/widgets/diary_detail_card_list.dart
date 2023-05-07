import 'package:flutter/material.dart';

class DiaryDetailCardList extends StatelessWidget {
  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.yellow,
    Colors.cyan,
    Colors.brown,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _colors.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 60,
              height: 80,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _colors[index],
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        )
    );
  }
}
