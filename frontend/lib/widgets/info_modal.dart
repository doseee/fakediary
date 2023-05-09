import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoModal extends StatelessWidget {

  final double? height;
  final double padding;
  final Widget widget;
  final bool color;

  const InfoModal({Key? key, required this.widget, this.height, required this.color, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: 1,
    child: Dialog(
      backgroundColor: color ? Color(0xff0f2027) : Colors.transparent,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: EdgeInsets.all(padding),
              child: Center(
                child: widget,
              )
            ),
        ),
      ),
    );
  }
}
