class NotificationModel {
  int? id;
  String? notificationData;
  String? notificationDesc;
  String? notificationDataArabic;
  String? opened;
  int? userId;

  NotificationModel(
      {this.id,
      this.notificationData,
      this.notificationDesc,
      this.opened,
      this.userId,
      this.notificationDataArabic});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationData = json['notificationData'];
    notificationDesc = json['notificationDesc'];
    opened = json['opened'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notificationData'] = this.notificationData;
    data['notificationDesc'] = this.notificationDesc;
    data['opened'] = this.opened;
    data['userId'] = this.userId;
    return data;
  }
}
