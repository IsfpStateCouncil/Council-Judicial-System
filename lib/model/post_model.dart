import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    required this.userId,
    required this.id,
    required this.notificationDesc,
    required this.opened,
  });
  int userId;
  int id;
  String notificationDesc;
  String opened;
  factory Post.fromMap(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        notificationDesc: json["notificationDesc"],
        opened: json["opened"],
      );
}
