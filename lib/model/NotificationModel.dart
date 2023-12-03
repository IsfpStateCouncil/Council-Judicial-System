class NotificationModel {
  int? id;
  String? notificationData;
  String? notificationDesc;
  String? notificationDataArabic;
  String? notificationDataEnglish;
  String? opened;
  int? userId;
  int? notificationEventId;

  NotificationModel(
      {this.id,
      this.notificationData,
      this.notificationDesc,
      this.opened,
      this.userId,
      this.notificationDataArabic,
      this.notificationDataEnglish,
      this.notificationEventId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationData = json['notificationData'];
    notificationDesc = json['notificationDesc'];
    opened = json['opened'];
    userId = json['userId'];
    notificationEventId = json['notificationEventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notificationData'] = this.notificationData;
    data['notificationDesc'] = this.notificationDesc;
    data['opened'] = this.opened;
    data['userId'] = this.userId;
    data['notificationEventId'] = this.notificationEventId;
    return data;
  }
}
