class JudgicalYearDataModel {
  int? id;
  String? name;
  String? nextMovementYear;
  String? prevoiusMovementYear;

  JudgicalYearDataModel(
      {this.id, this.name, this.nextMovementYear, this.prevoiusMovementYear});

  JudgicalYearDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nextMovementYear = json['nextMovementYear'];
    prevoiusMovementYear = json['prevoiusMovementYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nextMovementYear'] = this.nextMovementYear;
    data['prevoiusMovementYear'] = this.prevoiusMovementYear;
    return data;
  }
}
