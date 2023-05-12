class AlarmModel {
  AlarmModel({
    required this.alarmId,
    required this.requestId,
    required this.alarmType,
    required this.body,
    required this.status,
    required this.title,
    required this.memberId,
  });
  late final int alarmId;
  late final int requestId;
  late final String alarmType;
  late final String body;
  late final int status;
  late final String title;
  late final int memberId;

  AlarmModel.fromJson(Map<String, dynamic> json) {
    alarmId = json['alarmId'];
    requestId = json['requestId'];
    alarmType = json['alarmType'];
    body = json['body'];
    status = json['status'];
    title = json['title'];
    memberId = json['memberId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alarmId'] = alarmId;
    data['requestId'] = requestId;
    data['alarmType'] = alarmType;
    data['body'] = body;
    data['status'] = status;
    data['title'] = title;
    data['memberId'] = memberId;
    return data;
  }
}
