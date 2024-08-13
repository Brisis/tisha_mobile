import 'dart:convert';

import 'package:equatable/equatable.dart';

class Input extends Equatable {
  final String id;
  final DateTime createdAt;
  final String name;
  final int quantity;
  final String unit;
  final String locationId;
  final String userId;
  const Input({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.locationId,
    required this.userId,
  });

  String toRawJson() => json.encode(toJson());

  Input.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        createdAt = DateTime.parse(json["createdAt"].toString()),
        name = json["name"],
        quantity = int.parse(json["quantity"].toString()),
        unit = json["unit"],
        locationId = json["locationId"],
        userId = json["userId"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "name": name,
        "quantity": quantity,
        "unit": unit,
        "locationId": locationId,
        "userId": userId,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        name,
        quantity,
        unit,
        locationId,
        userId,
      ];

  @override
  bool? get stringify => true;
}
