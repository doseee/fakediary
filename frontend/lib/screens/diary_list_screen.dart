import 'package:flutter/material.dart';
import 'package:frontend/screens/diary-list-filter.dart';
import 'package:frontend/screens/diary_create_cards.dart';
import 'package:frontend/screens/diary_detail_cover_screen.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:frontend/widgets/info_modal.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:lottie/lottie.dart';
import '../model/DiaryModel.dart';
import '../widgets/change_button.dart';

class DiaryListScreen extends StatefulWidget {
  // final int? recieverId; //답장 상황에서는 recieverId가 존재한다고 가정
  final int? requestId; //답장 상황에서는 requestId가 존재한다고 가정
  final int? alarmId;

  const DiaryListScreen({
    Key? key,
    // this.recieverId,
    this.requestId,
    this.alarmId,
  }) : super(key: key);

  @override
  State<DiaryListScreen> createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryListScreen> {
  late Future<List<DiaryModel>> diaries;
  late Future<List<DiaryModel>> holeDiaries;
  late Future<int> lengthDiaries;

  /// 1 은 내 일기 보기 && 친구 선택 안됨
  /// 2 는 내 일기 보기 && 친구에게 답장
  /// 3은 친구 일기 보기 && 카드, 교환버튼 표시 안됨
  int exchangeSituation = 1;
  int diaryId = -1;
  String title = '', summary = '', imageUrl = '';

  @override
  void initState() {
    super.initState();
    diaries = ApiService().getDiaries();
    // diaries = Future.value(widget.diaries);
    // holeDiaries = ApiService().getDiaries();
    print(diaries);
    if (widget.requestId != null) {
      print('thisway');
      setState(() {
        exchangeSituation = 2;
      });
    }
  }

  onSelect(
    int diaryId,
    String title,
    String summary,
    String imageUrl,
  ) {
    setState(() {
      this.diaryId = diaryId;
      this.title = title;
      this.summary = summary;
      this.imageUrl = imageUrl;
    });
  }

  Widget DiaryDetail() {
    if (diaryId == -1) {
      return Center(
        child: Lottie.asset('assets/lottie/book.json'),
      );
    }

    return Row(
      children: [
        Flexible(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 5),
                child:Stack(
                  children: [
                    Image.asset('assets/img/diary_cover.png',width: 130,height: 130), // 첫 번째 이미지
                    Positioned(
                      top: 11, // 두 번째 이미지의 위치 설정
                      left: 27,
                      child:  Image(
                        height: 90,
                        width: 90,
                        image: NetworkImage(imageUrl),
                      ), // 두 번째 이미지
                    ),
                  ],
                ) )),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      summary,
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Flexible(flex: 2, child: Row(
                //   children: [
                //     Flexible(flex: 1, child: Container(decoration: BoxDecoration(color: Colors.yellow)),),
                //     Flexible(flex: 1, child: Container(decoration: BoxDecoration(color: Colors.green)),)
                //   ],
                // ),),
                // SizedBox(height: 10,),
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BtnThemeGradientLine(),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                //Todo; [수정필요] 일기 디테일 페이지로 이동
                                builder: (context) => DiaryDetailCoverScreen(
                                  diaryId: diaryId,
                                  exchangeSituation: exchangeSituation,
                                  imageUrl: imageUrl,
                                ),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            maximumSize: Size(250, 40),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            )),
                        child: SizedBox(
                          width: 250,
                          height: 40,
                          child: Center(
                            child: SizedBox(
                              width: 250,
                              height: 40,
                              child: Center(
                                child: Text(
                                  '상세보기',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    ChangeButton(
                      exchangeSituation: exchangeSituation,
                      diaryId: diaryId,
                      requestId: widget.requestId,
                      alarmId: widget.alarmId,
                    ),
                    SizedBox(
                      // decoration: BtnThemeGradientLine(),
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          CheckKakao();
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
        return true;
      },
      child: Container(
        decoration: BgThemeIncludeImage(),
        // BoxDecoration(
        //   color: Colors.white60,
        // ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Container(
                color: Colors.white70,
              ),
            ),
            title: Row(
              children: [
                Text('일기장',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                Lottie.asset('assets/lottie/menu_grinstar.json', width: 30),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiaryCreateCards()));
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BtnThemeGradientLine(),
                        child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiaryFilter()));
                      },
                      child: Container(
                        width: 55,
                        height: 35,
                        decoration: BtnThemeGradientLine(),
                        child: Center(
                            child: Text(
                          '필터',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Image(
                        image: AssetImage(
                          'assets/img/home_icon.png',
                        ),
                        width: 45,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                                child: DiaryDetail()),
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
                                                  color: Colors.white70,
                                                  fontSize: 14),
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
                                                          color:
                                                              Colors.white70),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return InfoModal(
                                                                  padding: 20,
                                                                  color: true,
                                                                  widget: Text(
                                                                    '일기를 선택하면 표지, 타이틀, 요약 확인 및 일기 확인 페이지 이동, 교환이 가능합니다.',
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
                          print('data: ${snapshot.data?.length}');
                          if (snapshot.data?.isEmpty ?? true) {
                            return
                              Container(
                                child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DiaryCreateCards()));
                                },
                                child: Container(
                                  width: 250,
                                  height: 50,
                                  decoration: BtnThemeGradient(),
                                  child: Center(
                                    child: Text(
                                      '일기 만들러 가기',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                          }
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
      ),
    );
  }

  DefaultTemplate _getTemplate() {
    String title = this.title;
    Uri imageLink = Uri.parse(imageUrl);
    Link link = Link(
        webUrl: Uri.parse("https://www.naver.com"),
        mobileWebUrl: Uri.parse("https://developers.kakao.com"));

    Content content = Content(title: title, imageUrl: imageLink, link: link);

    FeedTemplate template = FeedTemplate(
      content: content,
      buttonTitle: '가짜 다이어리 기록하기',
    );

    return template;
  }

  void shareMyCode() async {
    try {
      DefaultTemplate template = _getTemplate();
      Uri uri = await ShareClient.instance.shareDefault(template: template);
      await ShareClient.instance.launchKakaoTalk(uri);
      print('카카오톡 공유 완료');
    } catch (error) {
      print('kakao error : ${error.toString()}');
    }
  }

  CheckKakao() async {
    bool isKakaoTalkSharingAvailable =
        await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      shareMyCode();
    } else {
      try {
        DefaultTemplate template = _getTemplate();
        Uri shareUrl =
            await WebSharerClient.instance.makeDefaultUrl(template: template);
        await launchBrowserTab(shareUrl, popupOpen: true);
        print('NoKakao');
      } catch (error) {
        print('kakao no install error : ${error.toString()}');
      }
    }
  }

  Widget buildList(snapshot) {
    print('imgUrl: ${snapshot[0].diaryImageUrl[0]}');
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.65,
      mainAxisSpacing: 0.1,
      padding: EdgeInsets.all(10.0),
      children: List.generate(snapshot.length, (index) {
        print('pic : ${snapshot[index].diaryImageUrl[0]}');
        return InkWell(
          onTap: () {
            print(
                '${snapshot[index].diaryId}, ${snapshot[index].title}, ${snapshot[index].summary}');
            onSelect(snapshot[index].diaryId, snapshot[index].title,
                snapshot[index].summary, snapshot[index].diaryImageUrl[0]);
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
                        Stack(
                          children: [
                            Image.asset('assets/img/diary_cover.png',width: 130,height: 130), // 첫 번째 이미지
                            Positioned(
                              top: 11, // 두 번째 이미지의 위치 설정
                              left: 27,
                              child:  Image(
                                height: 90,
                                width: 90,
                                image: NetworkImage(snapshot[index].diaryImageUrl[0]),
                              ), // 두 번째 이미지
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            snapshot[index].title.length > 17
                                ? (snapshot[index].title.substring(0, 17) +
                                    '...')
                                : snapshot[index].title,
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
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
