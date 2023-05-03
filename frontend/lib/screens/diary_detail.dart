import 'package:flutter/material.dart';

import '../services/api_service.dart';

class DiaryDetail extends StatelessWidget {
  const DiaryDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FloatingActionButton(
            onPressed: () {
              ApiService.askGpt('a');
            },
            child: Icon(Icons.arrow_back),
          )
        ],
      ),
    );
  }
}
