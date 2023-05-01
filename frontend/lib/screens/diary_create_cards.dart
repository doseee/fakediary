import 'package:flutter/material.dart';
import 'package:frontend/screens/menu_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/screens/mood_select.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryCreateCards extends StatefulWidget {
  const DiaryCreateCards({Key? key}) : super(key: key);

  @override
  _DiaryCreateState createState() => _DiaryCreateState();
}

class _DiaryCreateState extends State<DiaryCreateCards> {
  List temp = ["a", "b", "c", "d", "e", "b"];
  List<String> selectedCards = [];

  @override
  void initState() {
    super.initState();
    initId();
  }

  late int memberId;

  initId() async {
    final prefs = await SharedPreferences.getInstance();
    memberId = prefs.getInt('memberId')!;
    print(memberId);
    await ApiService().getCards(memberId);
  }

  Widget build(BuildContext context) {
    return (Container(
        decoration: BoxDecoration(
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
            ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1183,
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'CARDS  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen()));
                            },
                            child: Image(
                              image: AssetImage(
                                'assets/img/icon_menu_page.png',
                              ),
                              width: 45,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            body: Center(
                child: Column(children: [
              Flexible(
                flex: 1,
                child: GridView.count(
                  crossAxisCount: 5,
                  childAspectRatio: 4,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 1.0,
                  padding: EdgeInsets.all(5.0),
                  children: List.generate(
                    selectedCards.length,
                    (index) {
                      return Card(
                        color: Colors.transparent,
                        elevation: 0.0,
                        child: Column(
                          children: <Widget>[
                            Image(
                              image:
                                  AssetImage('assets/img/cardlist_tmpcard.png'),
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selectedCards[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            '이야기로 만들 기억의 조각을 선택하세요.',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  padding: EdgeInsets.all(10.0),
                  children: List.generate(
                    temp.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (selectedCards.contains(temp[index])) {
                              selectedCards.remove(temp[index]);
                            } else {
                              selectedCards.add(temp[index]);
                            }
                          });
                        },
                        child: Card(
                          color: selectedCards.contains(temp[index])
                              ? Colors.blue
                              : Colors.transparent,
                          elevation: 0.0,
                          child: Column(
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    'assets/img/cardlist_tmpcard.png'),
                                height: 110,
                                width: 110,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  temp[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      // navigate to the desired class
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MoodSelect()),
                      );
                    },
                    child: Container(
                        width: 268,
                        height: 61,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xff263344),
                              const Color(0xff1B2532).withOpacity(0.53),
                              const Color(0xff1C2A3D).withOpacity(0.5),
                              const Color(0xff1E2E42).withOpacity(0.46),
                              const Color(0xff364B66).withOpacity(0.33),
                              const Color(0xff2471D6).withOpacity(0),
                            ],
                            stops: const [0, 0.25, 0.4, 0.5, 0.75, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'NEXT',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )),
                  ))
            ])))));
  }
}
