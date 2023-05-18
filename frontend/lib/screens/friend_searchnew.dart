import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/model/SearchFriendModel.dart';
import 'package:frontend/services/api_service.dart';
import 'package:lottie/lottie.dart';

// import 'search_friend_model.dart'; // Replace this with the appropriate model file

const baseUrl =
    'https://example.com/api'; // Replace this with your API base URL

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Demo',
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchFriendModel> _searchResults = [];
  bool _isLoading = false;
  final FocusNode _searchFocusNode = FocusNode();
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
              ? Flushbar(
                      message: '친구요청 완료!',
                      duration: Duration(seconds: 3),
                      flushbarPosition: FlushbarPosition.TOP)
                  .show(context)
              : Flushbar(
                      message: '이미 친구 요청 했짜나 ㅠ',
                      duration: Duration(seconds: 3),
                      flushbarPosition: FlushbarPosition.TOP)
                  .show(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xff79F1A4),
                      Color(0xff0E5CAD),
                    ]),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  '친구 요청',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )),
              ),
            ),
          ],
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(6.0),
                child: Container(
                  height: 0.5,
                ),
              ),
              title: Row(
                children: [
                  Text('친구 찾기',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                  Lottie.asset('assets/lottie/menu_grinstar.json', width: 30),
                ],
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Lottie.asset('assets/lottie/friend_space.json',
                        width: 100),
                  ),
                  SizedBox(height: 20),
                  Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: _searchFocusNode,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: '닉네임을 검색하세요',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 0.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: () {

                              _onSearch(_searchController.text);
                                _searchFocusNode.unfocus(); // Dismiss the keyboard
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Flexible(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                              flex: 4,
                              child: ListView.builder(
                                itemCount: _searchResults.length,
                                itemBuilder: (BuildContext context, int index) {
                                  SearchFriendModel friend =
                                      _searchResults[index];
                                  return Center(
                                      child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset('assets/lottie/friend_planet.json',width:40,height:40),

                                          Text(
                                            friend.nickname.toString(),
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                          Expanded(
                                              child:
                                                  _buttonAdd(friend.memberId)),
                                          SizedBox(width: 8),
                                          // 각 위젯 사이에 간격을 주기 위해 SizedBox를 사용합니다.
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 0.2,
                                        color: Colors.white,
                                      )
                                    ],
                                  ));
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child:
                        Lottie.asset('assets/lottie/stars.json', height: 120),
                  ),
                ],
              ),
            )));
  }
}
