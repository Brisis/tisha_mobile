import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tisha_app/data/models/user.dart';

class Feedback extends Equatable {
  final String id;
  final String message;
  final User user;
  final DateTime createdAt;

  const Feedback({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.user,
  });

  String toRawJson() => json.encode(toJson());

  Feedback.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        message = json["message"],
        createdAt = DateTime.parse(json["createdAt"].toString()),
        user = User.fromJson(json["user"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "createdAt": createdAt,
        "user": user.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        message,
        createdAt,
        user,
      ];

  @override
  bool? get stringify => true;
}
