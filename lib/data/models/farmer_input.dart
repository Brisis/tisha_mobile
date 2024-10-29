import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/data/models/location.dart';

class FarmerInput extends Equatable {
  final String id;
  final DateTime createdAt;
  final String userId;
  final bool received;
  final double? payback;
  final int quantity;
  final Input input;
  final FarmerUser? user;

  const FarmerInput({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.received,
    this.payback,
    required this.quantity,
    required this.input,
    this.user,
  });

  String toRawJson() => json.encode(toJson());

  FarmerInput.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        createdAt = DateTime.parse(json["createdAt"].toString()),
        userId = json["userId"],
        received = json["received"],
        payback = json["payback"] == null
            ? null
            : double.parse(json["payback"].toString()),
        quantity = int.parse(json["quantity"].toString()),
        input = Input.fromJson(json["input"]),
        user = json["user"] == null ? null : FarmerUser.fromJson(json["user"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "userId": userId,
        "received": received,
        "payback": payback,
        "quantity": quantity,
        "input": input.toJson(),
        "user": user?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        userId,
        received,
        payback,
        quantity,
        input,
        user,
      ];

  @override
  bool? get stringify => true;
}

class FarmerUser extends Equatable {
  final String id;
  final String name;
  final String? surname;
  final Location? location;

  const FarmerUser({
    required this.id,
    required this.name,
    this.surname,
    this.location,
  });

  String toRawJson() => json.encode(toJson());

  FarmerUser.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["firstname"],
        surname = json["lastname"] == null ? null : json["lastname"] as String,
        location = json["location"] == null
            ? null
            : Location.fromJson(json["location"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
      ];

  @override
  bool? get stringify => true;
}
