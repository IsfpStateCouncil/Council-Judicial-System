class CaseStatuseModel {
  String? changeDate;
  String? icon;
  int? id;
  String? name;

  CaseStatuseModel({this.changeDate, this.icon, this.id, this.name});

  CaseStatuseModel.fromJson(Map<String, dynamic> json) {
    changeDate = json['changeDate'];
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['changeDate'] = this.changeDate;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
