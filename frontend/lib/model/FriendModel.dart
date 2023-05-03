class FriendModel {
  FriendModel({
    required this.memberId,
    required this.friendId,
    required this.nickname,
  });
  late final int memberId;
  late final int friendId;
  late final String nickname;

  FriendModel.fromJson(Map<String, dynamic> json){
    memberId = json['memberId'];
    friendId = json['friendId'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['memberId'] = memberId;
    _data['friendId'] = friendId;
    _data['nickname'] = nickname;
    return _data;
  }
}