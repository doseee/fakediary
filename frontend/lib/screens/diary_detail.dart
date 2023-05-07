import 'package:flutter/material.dart';
import 'package:frontend/model/DiaryModel.dart';
import 'package:frontend/widgets/compass_divider.dart';

import '../services/api_service.dart';

class DiaryDetailScreen extends StatefulWidget {
  final int diaryId;

  const DiaryDetailScreen({super.key, required this.diaryId});

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  late Future<DiaryModel> diary;
  late List<String> subtitles;
  late List<String> details;
  final ScrollController _scrollController = ScrollController();

  getDiaryModel() {
    diary = ApiService.getDiaryDetail(widget.diaryId);
    subtitles = ["1장소제목", "2장소제목", "3장소제목"];
    // subtitles = diary.subtitles.split('@');
    // details = diary.detail.split('@');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDiaryModel();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff42505C),
            Color(0xffE38B8B),
          ],
          stops: [0.4, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: FutureBuilder(
            future: diary,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final diary = snapshot.data as DiaryModel;
                details = diary.detail.split('@');
                List<Widget> buildDiaryItems() {
                  List<Widget> items = [];
                  items.add(Text(
                    diary.summary,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ));
                  items.add(SizedBox(
                    height: 20,
                  ));
                  for (int i = 0; i < details.length; i++) {
                    items.add(Image(
                        image: AssetImage(
                            'assets/img/illustration_test${i + 1}.png')));
                    items.add(SizedBox(
                      height: 30,
                    ));
                    items.add(
                      Text(
                        details[i],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    );
                    items.add(SizedBox(
                      height: 20,
                    ));
                    if (i != details.length - 1) {
                      items.add(CompassDivider(isExpanded: true));
                      items.add(SizedBox(
                        height: 20,
                      ));
                    }
                  }
                  return items;
                }

                List<Widget> diaryItems = buildDiaryItems();

                int subtitleIndex = 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        pinned: true,
                        title: Text(
                          subtitles[subtitleIndex],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return diaryItems[index];
                          },
                          childCount: diaryItems.length,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
