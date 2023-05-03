class DiaryModel {
  DiaryModel({
    required this.diaryId,
    required this.memberId,
    this.characters,
    this.places,
    required this.keyword,
    required this.prompt,
    required this.title,
    this.subtitles,
    required this.detail,
    required this.summary,
    required this.genre,
    required this.exchanged,
  });
  late final int diaryId;
  late final int memberId;
  late final Null characters;
  late final Null places;
  late final List<String> keyword;
  late final String prompt;
  late final String title;
  late final Null subtitles;
  late final String detail;
  late final String summary;
  late final String genre;
  late final bool exchanged;

  DiaryModel.fromJson(Map<String, dynamic> json){
    diaryId = json['diaryId'];
    memberId = json['memberId'];
    characters = json.containsKey('characters') ? json['characters'] : null;
    places = json.containsKey('places') ? json['places'] : null;
    keyword = List.castFrom<dynamic, String>(json['keyword']);
    prompt = json['prompt'];
    title = json['title'];
    subtitles = json.containsKey('subtitles') ? json['subtitles'] : null;
    detail = json['detail'];
    summary = json['summary'];
    genre = json['genre'];
    exchanged = json['exchanged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['diaryId'] = diaryId;
    _data['memberId'] = memberId;
    _data['characters'] = characters;
    _data['places'] = places;
    _data['keyword'] = keyword;
    _data['prompt'] = prompt;
    _data['title'] = title;
    _data['subtitles'] = subtitles;
    _data['detail'] = detail;
    _data['summary'] = summary;
    _data['genre'] = genre;
    _data['exchanged'] = exchanged;
    return _data;
  }
}