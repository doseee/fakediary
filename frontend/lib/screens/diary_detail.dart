import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/api_service.dart';

class DiaryDetail extends StatefulWidget {
  const DiaryDetail({super.key});

  @override
  State<DiaryDetail> createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  List<Map<String, String>> messages = [];
  String title = '';
  String desc = '';
  List<dynamic> contents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FloatingActionButton(
            onPressed: () async {
              messages = await ApiService.makeDiaryContents(
                  messages, '주인공은 문성현이고 장소는 안드로메다이고 키워드는 커피, 운세, 라벨이야');
              print(messages);
              String jsonResp = "";
              for (var message in messages) {
                if (message['role'] == 'assistant') {
                  jsonResp = jsonResp + message['content']!;
                }
              }
              final decoded = json.decode(jsonResp);
              title = decoded['title'];
              desc = decoded['desc'];
              contents = decoded['contents'];
              setState(() {});
            },
            child: Icon(Icons.arrow_back),
          ),
          Text(title),
          Text(desc),
          for (var content in contents) Text(content),
        ],
      ),
    );
  }
}
