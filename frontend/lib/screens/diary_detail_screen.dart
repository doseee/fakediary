import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/CardUrlListVerModel.dart';
import 'package:frontend/screens/diary_list_screen.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/change_button.dart';
import 'package:frontend/widgets/compass_divider.dart';
import 'package:frontend/widgets/dashed_line.dart';
import 'package:frontend/widgets/diary_detail_card_list.dart';
import 'package:frontend/widgets/theme.dart';

// import '../model/CardUrlListVerModel.dart';
import '../model/DiaryModel.dart';
import '../widgets/info_modal.dart';
import '../widgets/line_widget.dart';

class DiaryDetailScreen extends StatefulWidget {
  final int diaryId;

  /// 1 or 2는 내 일기라서 카드, 교환 버튼 표시
  /// 3은 친구 일기라 카드, 교환버튼 표시 안됨
  final int exchangeSituation;

  const DiaryDetailScreen(
      {Key? key, required this.diaryId, required this.exchangeSituation})
      : super(key: key);

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  late ScrollController _scrollController;
  late int slideNum = 0;

  ///모바일 화면을 일정한 크기의 slide로 나누었을 때 몇번째 슬라이드인지 인덱스 번호
  late Future<DiaryModel> diary;

  ///API로 받아온 다이어리 모델
  late List<String> details;

  ///다이어리 모델 중 디테일 리스트
  late Future<List<CardUrlListVerModel>> cards;

  /// SliverAppBar 투명도 변경하는 변수
  late bool _isTransparent = false;

  /// 구분선 확장 상태 관리하는 변수
  late bool _isExpanded = true;

  final default_image_url =
      'http://fakediary.s3.amazonaws.com/image-20230506-215519.png';

  /// 오디오 플레이어
  final player = AudioPlayer();
  bool isPlaying = false;

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.yellow,
    Colors.cyan,
    Colors.brown,
    Colors.grey,
  ];

  /// 일기를 받아오는 API 호출
  getDiaryModel() {
    diary = ApiService.getDiaryDetail(widget.diaryId);
  }

  /// 화면 첫 렌더링 시 수행
  @override
  void initState() {
    super.initState();
    print(widget.diaryId);

    _scrollController = ScrollController();

    /// 스크롤 컨트롤러
    _scrollController.addListener((changeSelector));

    /// scroll 상태에 따라 slide 변경

    getDiaryModel();

    /// 일기를 받아오는 API 호출
    cards = ApiService.getCardsbyDiaryId(widget.diaryId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    player.stop();
    player.dispose();
    super.dispose();
  }

  /// scroll 상태에 따라 slide 변경하는 함수
  changeSelector() {
    var maxScrollValue = _scrollController.position.maxScrollExtent;

    /// 화면 전체 높이
    var scrollValue = _scrollController.offset.round();

    ///현재 스크롤한 위치를 반올림한 값
    var divisor = (maxScrollValue / (details.length + 2)) + 80;

    /// 전체 크기를 화면구성요소 개수로 나누고 +80하며 슬라이드 하나가 차지할 크기를 계산
    var slideNum = (scrollValue / divisor).round();

    ///현재 스크롤 위치를 기반으로 슬라이드 번호 계산

    /// 슬라이드 넘버 설정
    setState(() {
      this.slideNum = slideNum;
    });

    var isExpanded = false;

    ///구분선 확장 관리 변수
    var isTransparent = false;

    /// SliverAppBar 투명도 관리 변수

    if (slideNum == 0) {
      /// 첫번째 슬라이드라면
      isExpanded = true;

      /// 구분선 확장 시작
    } else if (slideNum > 0 && slideNum <= details.length) {
      /// 두번째 슬라이드부터 마지막 디테일 슬라이드까지
      isTransparent = true;

      /// 투명도 상태 변경
      isExpanded = false;

      /// 구분선 상태 변경
    }

    ///변경 사항 업데이트
    setState(() {
      this.slideNum = slideNum;
      _isExpanded = isExpanded;
      _isTransparent = isTransparent;
    });
  }

  /// SliverAppBar에 표시될 타이틀 상태 관리
  /// FutureBuilder 내에 포함되기 때문에 setStatus(){} 사용 불가
  String title(subtitles) {
    if (slideNum > 0 && slideNum <= details.length) {
      /// 디테일 개수 안에 있는 서브타이틀
      return subtitles[slideNum - 1];

      ///표시
      /// slideNum은 첫표지, 마지막 표지가 있으므로 제대로 된 subtitles의 위치는 index-1
    } else {
      /// 처음과 마지막엔 subtitle 존재하지 않음
      return '';
    }
  }

  /// 음악 플레이어
  void playMusic() async {
    await player.setSource(
      AssetSource('wav/test_music2.wav'),
    );
    // await player.setReleaseMode(ReleaseMode.loop);
    await player.resume();
    isPlaying = true;
    print('played');
    setState(() {});
  }

  void stopMusic() async {
    await player.stop();
    isPlaying = false;
    print('stopped');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          /// 뒤로가기 방지
          /// 뒤로 가기 막지 않으면 표지 렌더링 오류
          /// 뒤로 가기 실행 시 일기 리스트로 이동하도록 조절
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DiaryListScreen()));

          /// 음악 종료
          player.dispose();
          return false;
        },
        child: Scaffold(
            body: FutureBuilder<DiaryModel>(

                /// API로 가져온 다이어리 모델 요소 사용
                future: diary,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    /// 데이터가 있다면
                    details = snapshot.data!.detail.split('@');

                    ///details split 하여 미리 만들어둔 details 리스트로 갱신
                    return contentList(snapshot.data!, details);

                    /// 현재 diary 정보를 이용하여 화면 구성
                  } else if (snapshot.hasError) {
                    /// 정보가 없다면 에러 표시
                    return Text("${snapshot.error}에러!!");
                  }
                  return Center(child: CircularProgressIndicator());

                  /// 통신할 때 렌더링 중이라는 표시
                })));
  }

  /// 카드리스트가 있는 경우와 없는 경우로 나누어 위젯 구성
  Widget CheckCard() {
    if (colors.isEmpty) {
      return Container();
    }

    return DiaryDetailCardList(
      cards: cards,
    );

    /// 카드가 있을 경우 나열하는 위젯
  }

  /// 단순히 친구의 읽기를 읽는 경우 / 아닌 경우 구분
  Widget CheckFriendLetter() {
    /// 3은 친구 일기 보기 && 카드, 교환버튼 표시 안됨
    if (widget.exchangeSituation == 3) {
      return Container();
    }

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(25.0),

        /// 상하좌우 패딩 25 적용
        child: Column(
          children: [
            Center(child: CheckCard()),

            /// 일기를 만드는 데 사용한 카드
            SizedBox(
              /// 중간 간격
              height: 30,
            ),
            ChangeButton(
              /// 교환 버튼
              exchangeSituation: widget.exchangeSituation,

              ///현재 교환 상태가 어떠한지 parameter로 넘김
              diaryId: widget.diaryId,

              /// 지금 상세페이지로 조회하고 있는 다이어리 아이디 parameter로 넘김
            )
          ],
        ),
      ),
    );
  }

  /// 일기 상세 내용 레이아웃 위젯
  /// parameter
  /// (1) details : 일기상세
  /// (2) subtitles : 서브타이틀 리스트
  /// (3) index : 서브타이틀 인덱스
  /// (4) 다이어리에 사용되는 이미지 url
  Widget getCard(
      details, List<String>? subtitles, int index, List<String> diaryImageUrl) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 25, right: 25),
      child: SizedBox(

          /// 전체 크기
          width: 150,
          child: Column(
            children: [
              /// 서브타이틀 위젯
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Text(
                  subtitles![index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    fontFamily: 'Cafe24',
                  ),
                ),
              ),

              /// 삽화 위젯
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: SizedBox(
                  /// 삽화 높이
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(

                                /// diaryImageUrl 리스트에서 S3에 저장된 Url을 가져와 NetworkImage로 띄움
                                diaryImageUrl.length > index + 1
                                    ? diaryImageUrl[index + 1]
                                    : default_image_url),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),

              /// 일기 디테일
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  /// 왼쪽 정렬
                  alignment: Alignment.topLeft,
                  child: Text(
                    details,
                    style: TextStyle(

                        /// 일기 텍스트 스타일
                        /// (1) 색 : 하얀색
                        /// (2) 폰트사이즈 : 16
                        /// (3) 줄 간격 : 1.5
                        /// (4) 자간 : 1.1
                        /// (5) 폰트 이름 : 카페24 써라운드 에어
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 1.1,
                        fontFamily: 'Cafe24'),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),

                /// 구분선 : 점선
                child: DashedLine(),
              )
            ],
          )),
    );
  }

  /// 일기 타이틀
  /// parameter : (String) 타이틀 내용
  Widget buildArtworkTitle(title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  /// 일기 디테일 레이아웃 위젯
  /// parameter
  /// (1) DiaryModel 타입 객체
  /// (2) 디테일(일기 상세 내용) 리스트
  Widget contentList(DiaryModel diary, List<String> details) {
    return Container(
      /// 배경화면 lib/widgets/theme.dart - BgThemeGradientDiary()
      decoration: BgThemeGradientDiary(),

      /// SliverAppBar 사용을 위해 CustomScrollView 위젯
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            /// AppBar의 background Color 상태 변화
            /// (1) true : 배경 색으로 고정 (일기 디테일이 스크롤 이벤트에 걸릴때)
            /// (2) false : 맨 위 슬라이드, 맨 아래 슬라이드에선 배경화면 투명
            backgroundColor:
                _isTransparent ? Color(0xff0F2027) : Colors.transparent,

            /// 그림자 제거
            elevation: 0,

            /// AppBar에 표시될 텍스트 : 다이어리 서브 타이틀 리스트
            title: Row(
              children: [
                Expanded(
                  child: Text(title(diary.subtitles)),
                ),
                GestureDetector(
                  onTap: () {
                    isPlaying ? stopMusic() : playMusic();
                  },
                  child: Image(
                    image: isPlaying
                        ? AssetImage('assets/img/music_off.png')
                        : AssetImage('assets/img/music_icon.png'),
                    width: 50,
                  ),
                ),
              ],
            ),

            /// 고정 여부
            pinned: true,
            floating: false,

            /// expandedHeight 속성을 사용하여 헤더 사이즈 조절
            /// flexibleSpace 속성을 사용하여 SliverAppBar 위젯의 flexible space에 이미지 배치
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: diary.diaryImageUrl.isNotEmpty
                  ? Image(
                      image: NetworkImage(diary.diaryImageUrl[0]),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),

          /// 첫번째 슬라이드
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Column(
                        children: [
                          /// 상단 구분선
                          Flexible(
                            flex: 1,
                            child: CompassDivider(
                              isExpanded: _isExpanded,
                            ),
                            // LineImgAnimation(),
                          ),

                          /// 타이틀
                          Flexible(
                            flex: 4,
                            child: buildArtworkTitle(diary.title),

                            /// 타이틀 스타일 위젯
                          ),

                          /// 하단 구분선
                          Flexible(
                            flex: 1,
                            child: LineWidget(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          /// 일기 상세 내용
          ...details.map((e) {
            /// 일기 상세 내용 리스트를 돌면서 몇 장인지 index 추출
            final index = details.indexOf(e);

            /// 투명도 효과 적용
            return SliverAnimatedOpacity(
              /// 아직 스크롤이 닿지 않은 위치 투명도 0.5로 설정
              /// = 현재 인덱스가 slideNum보다 작은 경우
              opacity: index < slideNum ? 1.0 : 0.5,
              duration: Duration(microseconds: 500),
              curve: Curves.ease,
              sliver: SliverToBoxAdapter(
                /// 각 장 별 레이아웃 위젯
                child: getCard(e, diary.subtitles, index, diary.diaryImageUrl),
              ),
            );
          }).toList(),

          /// 교환 버튼
          SliverToBoxAdapter(
            child: CheckFriendLetter(),
          ),
          SliverToBoxAdapter(
            child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(color: Colors.white10),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return InfoModal(
                                padding: 20,
                                color: true,
                                widget: Column(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          '일기를 지우시겠습니까?',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white60),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        decoration: BtnThemeGradientLine(),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                )),
                                            onPressed: () async {
                                              await ApiService.deleteDiary(
                                                  widget.diaryId);
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DiaryListScreen()));
                                              player.dispose();
                                            },
                                            child: Center(
                                              child: Text('삭제'),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                                height: MediaQuery.of(context).size.height / 4);
                          });
                    },
                    child: Center(
                        child: Text(
                      '일기 지우기',
                      style: TextStyle(color: Colors.white60),
                    )),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
