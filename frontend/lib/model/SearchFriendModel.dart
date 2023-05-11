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
  late final void autoDiaryTime;
  late final void diaryBaseName;
  late final void firebaseUid;
  late final void providerId;
  late final bool randomExchanged;

  SearchFriendModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'] ?? '';
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
    final data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['memberId'] = memberId;
    data['email'] = email;
    data['password'] = password;
    data['nickname'] = nickname;
    // data['autoDiaryTime'] = autoDiaryTime;
    // data['diaryBaseName'] = diaryBaseName;
    // data['firebaseUid'] = firebaseUid;
    // data['providerId'] = providerId;
    data['randomExchanged'] = randomExchanged;
    return data;
  }
}
