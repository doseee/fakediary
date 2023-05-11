import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import '../model/CardModel.dart';
import '../model/CardUrlListVerModel.dart';
import 'card_modal.dart';

class DiaryDetailCardList extends StatelessWidget {
  final Future<List<CardUrlListVerModel>> cards;

  const DiaryDetailCardList({Key? key, required this.cards}) : super(key: key);

  String titleCheck(snapshot) {
    if (snapshot.keywords.length != 0) {
      return snapshot.keywords[0];
    } else if (snapshot.baseName != '') {
      return snapshot.baseName;
    }

    return snapshot.basePlace;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: FutureBuilder<List<CardUrlListVerModel>>(
        future: cards,
        builder: (BuildContext context, AsyncSnapshot<List<CardUrlListVerModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Future<CardModel> model = ApiService.findCard(snapshot.data![index].cardId);
                return InkWell(
                    onTap: () {
                  showModalBottomSheet(

                    context: context,
                    builder: (context) {
                      return FutureBuilder<CardModel>(
                        future: model,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            print('snapshot : ${snapshot.data}');
                            return CardModal(
                              cardTitle: titleCheck(snapshot.data!),
                              card: snapshot.data!,
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text('No data found.');
                          }
                        },
                      );
                  });
                },
                child: Container(
                  width: 60,
                  height: 80,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        snapshot.data![index].cardImageUrl,
                      ),
                      fit: BoxFit.cover
                    ),// assuming you have a list of colors to use
                    borderRadius: BorderRadius.circular(10),
                  ),
                ));
              },
            );
          } else {
            return Center(
              child: Text('No data found.'),
            );
          }
        },
      ),
    );
  }
}
