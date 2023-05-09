import 'package:flutter/material.dart';
import 'package:frontend/model/SearchFriendModel.dart';
import 'package:frontend/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'search_friend_model.dart'; // Replace this with the appropriate model file

const baseUrl =
    'https://example.com/api'; // Replace this with your API base URL

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Demo',
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchFriendModel> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onSearch(String searchText) async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<SearchFriendModel> results =
          await ApiService().getSearchFriends(searchText);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buttonAdd(senderID) {
    return GestureDetector(
        onTap: () async {
          bool isSended = await ApiService.AddFriend(senderID);
          isSended
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(child: Text('친구요청 완료!')),
                  ),
                )
              :  ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('이미 친구 요청 했짜나 ㅠ')),
            ),
          );
        },
        child: Center(
          child: Container(
            width: 90,
            height: 40,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff79F1A4),
                  Color(0xff0E5CAD),
                ]),
                borderRadius: BorderRadius.circular(25)),
            child: Center(
                child: Text(
              'ADD',
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/background_pink_darken.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('친구 검색'),
        ),
        body: Column(
          children: [
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '닉네임을 검색하세요',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.teal),
                    onPressed: () {
                      _onSearch(_searchController.text);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 330,
              height: 300,
              padding: EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _searchResults.isNotEmpty
                        ? ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (BuildContext context, int index) {
                              SearchFriendModel friend = _searchResults[index];
                              return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 60),
                                  Text(friend.nickname.toString() , style: TextStyle(fontSize: 20),),
                                  Expanded(child: _buttonAdd(friend.memberId)),
                                  SizedBox(width: 8),
                                  // 각 위젯 사이에 간격을 주기 위해 SizedBox를 사용합니다.

                                ],
                              ));
                            },
                          )
                        : Center(
                            child: Text(
                            '해당 친구는 존재하지 않아요!',
                            style: TextStyle(color: Colors.black),
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
