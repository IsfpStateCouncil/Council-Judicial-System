import 'JudgicalYearDataModel.dart';

class JudgicalYearsModel {
  int? count;
  List<JudgicalYearDataModel>? judgicalYearData;
  String? message;
  String? messageDetails;
  int? success;

  JudgicalYearsModel(
      {this.count,
      this.judgicalYearData,
      this.message,
      this.messageDetails,
      this.success});

  JudgicalYearsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['judgicalYearData'] != null) {
      judgicalYearData = <JudgicalYearDataModel>[];
      json['judgicalYearData'].forEach((v) {
        judgicalYearData!.add(new JudgicalYearDataModel.fromJson(v));
      });
    }
    message = json['message'];
    messageDetails = json['messageDetails'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.judgicalYearData != null) {
      data['judgicalYearData'] =
          this.judgicalYearData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['messageDetails'] = this.messageDetails;
    data['success'] = this.success;
    return data;
  }
}
