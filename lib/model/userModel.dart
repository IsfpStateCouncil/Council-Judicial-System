import 'dart:convert';

List<UserData> Class_dataFromJson(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromMap(x)));

class UserData {
  UserData({
    required this.courtName,
    required this.id,
    required this.judicialYear,
    this.nextHearingDate = "",
    required this.serial,
  });
  final String courtName;
  final int id;
  final int judicialYear;
  final String nextHearingDate;
  final int serial;
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      courtName: map['courtName'] ?? "",
      id: map['id'] ?? 0,
      judicialYear: map['judicialYear'] ?? 0,
      nextHearingDate: map['nextHearingDate'] ?? "",
      serial: map['serial'] ?? 0,
    );
  }
}
