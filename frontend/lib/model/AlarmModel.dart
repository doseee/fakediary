class AlarmModel {
  AlarmModel({
    required this.alarmId,
    required this.createdAt,
    required this.updatedAt,
    required this.alarmType,
    required this.body,
    required this.status,
    required this.title,
    required this.memberId,
    required this.requestId,
  });
  late final int alarmId;
  late final String createdAt;
  late final String updatedAt;
  late final String alarmType;
  late final String body;
  late final int status;
  late final String title;
  late final int memberId;
  late final int requestId;

  AlarmModel.fromJson(Map<String, dynamic> json) {
    alarmId = json['alarmId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    alarmType = json['alarmType'];
    body = json['body'];
    status = json['status'];
    title = json['title'];
    memberId = json['memberId'];
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alarmId'] = alarmId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['alarmType'] = alarmType;
    data['body'] = body;
    data['status'] = status;
    data['title'] = title;
    data['memberId'] = memberId;
    data['requestId'] = requestId;
    return data;
  }
}
