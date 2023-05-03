import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoModal extends StatelessWidget {

  final String text;
  final double? height;

  const InfoModal({Key? key, required this.text, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: 0.5,
    child: Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: EdgeInsets.all(20),
              child: Center(
                child:  Text(text),
              )
            ),
        ),
      ),
    );
  }
}
