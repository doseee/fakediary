class DiaryModel {
  DiaryModel({
    required this.diaryId,
    required this.memberId,
    this.characters,
    this.places,
    this.keyword,
    required this.prompt,
    required this.title,
    this.subtitles,
    required this.detail,
    required this.summary,
    required this.genre,
    required this.diaryImageUrl,
    required this.exchanged,
    this.musicUrl,
    required this.createdAt,
  });
  late final int diaryId;
  late final int memberId;
  late final List<String>? characters;
  late final List<String>? places;
  late final List<String>? keyword;
  late final String prompt;
  late final String title;
  late final List<String>? subtitles;
  late final String detail;
  late final String summary;
  late final List<String> genre;
  late final List<String> diaryImageUrl;
  late final bool exchanged;
  late final String? musicUrl;
  late final String createdAt;

  DiaryModel.fromJson(Map<String, dynamic> json) {
    diaryId = json['diaryId'];
    memberId = json['memberId'];
    characters = json['characters'] != null
        ? List<String>.from(json['characters'].map((dynamic x) => x as String))
        : [];
    places = json['places'] != null
        ? List<String>.from(json['places'].map((dynamic x) => x as String))
        : [];
    keyword = json['keyword'] != null
        ? List<String>.from(json['keyword'].map((dynamic x) => x as String))
        : [];
    prompt = json['prompt'];
    title = json['title'];
    subtitles = json['subtitles'] != null
        ? List<String>.from(json['subtitles'].map((dynamic x) => x as String))
        : [];
    detail = json['detail'];
    summary = json['summary'];
    genre = json['genre'] != null
        ? List.castFrom<dynamic, String>(json['genre'])
        : [];
    diaryImageUrl = json['diaryImageUrl'].isEmpty
        ? [
            'https://i.pinimg.com/originals/0c/13/17/0c131751a945ab87dfcbc819a805b954.jpg'
          ]
        : List<String>.from(json['diaryImageUrl']
            .map((dynamic x) => (x as String).replaceFirst('s', '')));
    exchanged = json['exchanged'];
    musicUrl = json['musicUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['diaryId'] = diaryId;
    data['memberId'] = memberId;
    data['characters'] = characters;
    data['places'] = places;
    data['keyword'] = keyword;
    data['prompt'] = prompt;
    data['title'] = title;
    data['subtitles'] = subtitles;
    data['detail'] = detail;
    data['summary'] = summary;
    data['genre'] = genre;
    data['diaryImageUrl'] = diaryImageUrl;
    data['exchanged'] = exchanged;
    data['musicUrl'] = musicUrl;
    data['createdAt'] = createdAt;
    return data;
  }
}
