import 'package:flutter/material.dart';

class DiaryDetailCardList extends StatelessWidget {

  final List colors;

  const DiaryDetailCardList({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 60,
              height: 80,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        )
    );
  }
}
