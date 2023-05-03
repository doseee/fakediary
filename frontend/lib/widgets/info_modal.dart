import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoModal extends StatelessWidget {

  final double? height;
  final Widget widget;

  const InfoModal({Key? key, required this.widget, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: 1,
    child: Dialog(
      backgroundColor: Color(0xff0f2027),
      child: SizedBox(
        height: height,
        child: Padding(
          padding: EdgeInsets.all(20),
              child: Center(
                child: widget,
              )
            ),
        ),
      ),
    );
  }
}
