class CardModel {
  CardModel({
    required this.cardId,
    required this.memberId,
    required this.nickName,
    required this.baseName,
    required this.basePlace,
    required this.keywords,
    required this.cardImageUrl,
    required this.createdAt,
  });
  late final int cardId;
  late final int memberId;
  late final String nickName;
  late final String baseName;
  late final String basePlace;
  late final List<String> keywords;
  late final String cardImageUrl;
  late final String createdAt;

  CardModel.fromJson(Map<String, dynamic> json) {
    cardId = json['cardId'];
    memberId = json['memberId'];
    nickName = json['nickName'];
    baseName = json['baseName'];
    basePlace = json['basePlace'];
    keywords =
        List<String>.from(json['keywords'].map((dynamic x) => x as String));
    cardImageUrl = json['cardImageUrl'].toString().replaceFirst('s', '');
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cardId'] = cardId;
    data['memberId'] = memberId;
    data['nickName'] = nickName;
    data['baseName'] = baseName;
    data['basePlace'] = basePlace;
    data['keywords'] = keywords;
    data['cardImageUrl'] = cardImageUrl;
    data['createdAt'] = createdAt;
    return data;
  }
}
