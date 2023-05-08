class SearchFriendModel {
  SearchFriendModel({
    required this.createdAt,
    required this.updatedAt,
    required this.memberId,
    required this.email,
    required this.password,
    required this.nickname,
    this.autoDiaryTime,
    this.diaryBaseName,
    this.firebaseUid,
    this.providerId,
    required this.randomExchanged,
  });
  late final String createdAt;
  late final String updatedAt;
  late final int memberId;
  late final String email;
  late final String password;
  late final String nickname;
  late final Null autoDiaryTime;
  late final Null diaryBaseName;
  late final Null firebaseUid;
  late final Null providerId;
  late final bool randomExchanged;

  SearchFriendModel.fromJson(Map<String, dynamic> json){
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    memberId = json['mem'
        'berId'];
    email = json['email'];
    password = json['password'];
    nickname = json['nickname'];
    autoDiaryTime = null;
    diaryBaseName = null;
    firebaseUid = null;
    providerId = null;
    randomExchanged = json['randomExchanged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['memberId'] = memberId;
    _data['email'] = email;
    _data['password'] = password;
    _data['nickname'] = nickname;
    _data['autoDiaryTime'] = autoDiaryTime;
    _data['diaryBaseName'] = diaryBaseName;
    _data['firebaseUid'] = firebaseUid;
    _data['providerId'] = providerId;
    _data['randomExchanged'] = randomExchanged;
    return _data;
  }
}