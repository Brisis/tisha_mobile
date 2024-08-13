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
  final double quantity;

  const InputApplication({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.accepted,
    required this.message,
    required this.input,
    required this.quantity,
  });

  String toRawJson() => json.encode(toJson());

  InputApplication.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        user = User.fromJson(json["user"]),
        createdAt = DateTime.parse(json["createdAt"].toString()),
        accepted = json["accepted"],
        message = json["message"],
        quantity = double.parse(json["quantity"].toString()),
        input = Input.fromJson(json["input"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "createdAt": createdAt,
        "accepted": accepted,
        "quantity": quantity,
        "message": message,
        "input": input.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        user,
        createdAt,
        quantity,
        accepted,
        message,
        input,
      ];

  @override
  bool? get stringify => true;
}

class UserInputApplication extends Equatable {
  final String id;
  final DateTime createdAt;
  final bool accepted;
  final String message;
  final Input input;
  final double quantity;

  const UserInputApplication({
    required this.id,
    required this.createdAt,
    required this.accepted,
    required this.message,
    required this.input,
    required this.quantity,
  });

  String toRawJson() => json.encode(toJson());

  UserInputApplication.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        createdAt = DateTime.parse(json["createdAt"].toString()),
        accepted = json["accepted"],
        message = json["message"],
        quantity = double.parse(json["quantity"].toString()),
        input = Input.fromJson(json["input"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "accepted": accepted,
        "quantity": quantity,
        "message": message,
        "input": input.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        quantity,
        accepted,
        message,
        input,
      ];

  @override
  bool? get stringify => true;
}
