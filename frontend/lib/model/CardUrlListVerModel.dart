class CardUrlListVerModel {
  CardUrlListVerModel({
    required this.cardId,
    required this.baseName,
    required this.basePlace,
    required this.keyword,
    required this.latitude,
    required this.longitude,
    required this.originCardImageName,
    required this.origImageUrl,
    required this.cardImageUrl,
    required this.cardStyleIndex,
    required this.cardStyleId,
  });
  late final int cardId;
  late final String baseName;
  late final String basePlace;
  late final String keyword;
  late final double latitude;
  late final double longitude;
  late final String originCardImageName;
  late final String origImageUrl;
  late final String cardImageUrl;
  late final int cardStyleIndex;
  late final String cardStyleId;

  CardUrlListVerModel.fromJson(Map<String, dynamic> json){
    cardId = json['cardId'];
    baseName = json['baseName'];
    basePlace = json['basePlace'];
    keyword = json['keyword'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    originCardImageName = json['originCardImageName'];
    origImageUrl = json['origImageUrl'];
    cardImageUrl = json['cardImageUrl'];
    cardStyleIndex = json['cardStyleIndex'];
    cardStyleId = json['cardStyleId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cardId'] = cardId;
    _data['baseName'] = baseName;
    _data['basePlace'] = basePlace;
    _data['keyword'] = keyword;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['originCardImageName'] = originCardImageName;
    _data['origImageUrl'] = origImageUrl;
    _data['cardImageUrl'] = cardImageUrl;
    _data['cardStyleIndex'] = cardStyleIndex;
    _data['cardStyleId'] = cardStyleId;
    return _data;
  }
}