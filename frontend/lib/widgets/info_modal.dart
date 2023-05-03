import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoModal extends StatelessWidget {

  final String text;

  const InfoModal({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: 0.5,
    child: Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 100,
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
