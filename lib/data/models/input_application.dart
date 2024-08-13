import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/data/models/user.dart';

class InputApplication extends Equatable {
  final String id;
  final DateTime createdAt;
  final User user;
  final bool accepted;
  final String message;
  final Input input;

  const InputApplication({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.accepted,
    required this.message,
    required this.input,
  });

  String toRawJson() => json.encode(toJson());

  InputApplication.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        user = User.fromJson(json["user"]),
        createdAt = DateTime.parse(json["createdAt"].toString()),
        accepted = json["accepted"],
        message = json["message"],
        input = Input.fromJson(json["input"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "createdAt": createdAt,
        "accepted": accepted,
        "message": message,
        "input": input.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        user,
        createdAt,
        accepted,
        message,
        input,
      ];

  @override
  bool? get stringify => true;
}
