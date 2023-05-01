class CardModel {
  CardModel({
    required this.cardId,
    required this.memberId,
    required this.nickName,
    required this.baseName,
    required this.basePlace,
    required this.keywords,
    required this.cardImageUrl,
  });
  late final int cardId;
  late final int memberId;
  late final String nickName;
  late final String baseName;
  late final String basePlace;
  late final List<String> keywords;
  late final String cardImageUrl;

  CardModel.fromJson(Map<String, dynamic> json){
    cardId = json['cardId'];
    memberId = json['memberId'];
    nickName = json['nickName'];
    baseName = json['baseName'];
    basePlace = json['basePlace'];
    keywords = List<String>.from(json['keywords'].map((dynamic x) => x as String));
    cardImageUrl = json['cardImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cardId'] = cardId;
    _data['memberId'] = memberId;
    _data['nickName'] = nickName;
    _data['baseName'] = baseName;
    _data['basePlace'] = basePlace;
    _data['keywords'] = keywords;
    _data['cardImageUrl'] = cardImageUrl;
    return _data;
  }
}