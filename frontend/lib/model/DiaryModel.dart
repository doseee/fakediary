class DiaryModel {
  DiaryModel({
    required this.diaryId,
    required this.memberId,
    required this.keyword,
    required this.prompt,
    required this.title,
    required this.detail,
    required this.summary,
    required this.exchanged,
  });
  late final int diaryId;
  late final int memberId;
  late final String keyword;
  late final String prompt;
  late final String title;
  late final String detail;
  late final String summary;
  late final bool exchanged;

  DiaryModel.fromJson(Map<String, dynamic> json){
    diaryId = json['diaryId'];
    memberId = json['memberId'];
    keyword = json['keyword'];
    prompt = json['prompt'];
    title = json['title'];
    detail = json['detail'];
    summary = json['summary'];
    exchanged = json['exchanged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['diaryId'] = diaryId;
    _data['memberId'] = memberId;
    _data['keyword'] = keyword;
    _data['prompt'] = prompt;
    _data['title'] = title;
    _data['detail'] = detail;
    _data['summary'] = summary;
    _data['exchanged'] = exchanged;
    return _data;
  }
}