import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/friend_screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:frontend/widgets/info_modal.dart';
import '../model/DiaryModel.dart';
import '../widgets/ChangeButton.dart';
import '../widgets/appbar.dart';


class DiaryFilteredScreen extends StatefulWidget {
  final List<DiaryModel> diaries;// diaries 변수 추가
  final int? recieverId; //답장 상황에서는 recieverId가 존재한다고 가정
  
  const DiaryFilteredScreen({Key? key, required this.diaries,this.recieverId}) : super(key: key);

  @override
  State<DiaryFilteredScreen> createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryFilteredScreen> {
  late Future<List<DiaryModel>> diaries;
  late Future<List<DiaryModel>> holeDiaries;
  late Future<int> lengthDiaries;
  int exchangeSituation = 1; //1이면 내가 교환 보내는 상황 2면 답장하는 상황
  int diaryId = -1;
  String title = '', summary = '';

  @override
  void initState() {
    super.initState();
      diaries = Future.value(widget.diaries);
    // diaries = Future.value(widget.diaries);
    // holeDiaries = ApiService().getDiaries();
    print(diaries);
    if(widget.recieverId != null){
      setState(() {
        exchangeSituation = 2;
      });
    }

  }


  onSelect(
    int diaryId,
    String title,
    String summary,
  ) {
    setState(() {
      this.diaryId = diaryId;
      this.title = title;
      this.summary = summary;
    });
  }

  Widget DiaryDetail(){
    if(diaryId == -1){
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/img/diary_list.png'))),
      );
    }

    return Row(
      children: [
        Flexible(flex: 1,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 5),
          child: Container(decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.all(Radius.circular(15))),
        ),),),
        Flexible(flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(flex: 3, child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(title, style: TextStyle(color: Colors.white60, fontSize: 18, fontWeight: FontWeight.w600),),
                ),),
                Flexible(flex: 3, child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(summary, style: TextStyle(color: Colors.white60, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis,),
                ),),
                // Flexible(flex: 2, child: Row(
                //   children: [
                //     Flexible(flex: 1, child: Container(decoration: BoxDecoration(color: Colors.yellow)),),
                //     Flexible(flex: 1, child: Container(decoration: BoxDecoration(color: Colors.green)),)
                //   ],
                // ),),
                // SizedBox(height: 10,),
                Flexible(flex: 3, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BtnThemeGradientLine(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //Todo; [수정필요] 일기 디테일 페이지로 이동
                                  builder: (context) => HomeScreen(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          child: Text(
                            '상세보기',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                    ),
                  ),
                ),),
                ChangeButton(exchangeSituation: exchangeSituation, diaryId: diaryId,),
              ],
            ),
          ),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BgThemeIncludeImage(),
      // BoxDecoration(
      //   color: Colors.white60,
      // ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: StandAppBar(context),
        body: Column(
          children: [
            Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Flexible(
                        flex: 6,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: DiaryDetail()
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: Column(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Flexible(
                                        flex: 4,
                                        child: Center(
                                          child: Text(
                                            '내가 만든 일기를 확인해보세요',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )),
                                    Flexible(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(),
                                            ),
                                            Flexible(
                                              flex: 11,
                                              child: Container(
                                                child: IconButton(
                                                    icon: Icon(Icons.info,
                                                        color: Colors.white),
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return InfoModal(
                                                                widget: Text(
                                                                  '일기를 선택하면 표지, 타이틀, 요약 확인 및 일기 확인 페이지 이동, 교환이 가능합니다',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                height: 100);
                                                          });
                                                    }),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Container(),
                                            )
                                          ],
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Flexible(
                flex: 3,
                child: Container(
                  // decoration: BgThemeIncludeImage(),
                  child: FutureBuilder<List<DiaryModel>>(
                    future: diaries,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print('data: ${snapshot.data}');
                        return buildList(snapshot.data);
                      } else if (snapshot.hasError) {
                        return Text("error : ${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                )
                // child: Container(),
                )
          ],
        ),
      ),
    );
  }

  Widget buildList(snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      mainAxisSpacing: 10.0,
      padding: EdgeInsets.all(10.0),
      children: List.generate(snapshot.length, (index) {
        print('length : ${snapshot.length}');
        return InkWell(
          onTap: () {
            print('${snapshot[index].diaryId}, ${snapshot[index].title}, ${snapshot[index].summary}');
            onSelect(snapshot[index].diaryId, snapshot[index].title,
                snapshot[index].summary);
          },
          child: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: Column(
                children: [
                  Card(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.white60, width: 4),
                            // Todo; 나중에 커버 이미지 url로 변경
                            // image: DecorationImage(
                            //     fit: BoxFit.cover,
                            //     image: NetworkImage(
                            //         snapshot[index].coverUrl
                            //     )
                            // )
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            snapshot[index].title,
                            style:
                                TextStyle(color: Colors.white60, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }
}