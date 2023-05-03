import 'package:flutter/cupertino.dart';

BoxDecoration BgThemeGradient(){
  return  BoxDecoration(
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
          ]));
}