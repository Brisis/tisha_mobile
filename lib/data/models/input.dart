import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tisha_app/data/models/enums.dart';

class Input extends Equatable {
  final String id;
  final DateTime createdAt;
  final String name;
  final int quantity;
  final String? unit;
  final InputType type;
  final InputScheme scheme;
  final String barcode;
  final String? chassisNumber;
  final String? engineType;
  final String? numberPlate;
  final String? color;
  final bool notified;
  final String locationId;
  final String userId;
  const Input({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.quantity,
    this.unit,
    required this.type,
    required this.scheme,
    required this.barcode,
    this.chassisNumber,
    this.engineType,
    this.numberPlate,
    this.color,
    required this.notified,
    required this.locationId,
    required this.userId,
  });

  String toRawJson() => json.encode(toJson());

  Input.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        createdAt = DateTime.parse(json["createdAt"].toString()),
        name = json["name"],
        quantity = int.parse(json["quantity"].toString()),
        unit = json["unit"] == null ? null : json["unit"] as String,
        type = InputType.values
            .firstWhere((value) => value.name == json["type"].toString()),
        scheme = InputScheme.values
            .firstWhere((value) => value.name == json["scheme"].toString()),
        barcode = json["barcode"],
        chassisNumber = json["chassisNumber"] == null
            ? null
            : json["chassisNumber"] as String,
        engineType =
            json["engineType"] == null ? null : json["engineType"] as String,
        numberPlate =
            json["numberPlate"] == null ? null : json["numberPlate"] as String,
        color = json["color"] == null ? null : json["color"] as String,
        notified = json["notified"],
        locationId = json["locationId"],
        userId = json["userId"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "name": name,
        "quantity": quantity,
        "unit": unit,
        "type": type.name,
        "scheme": scheme.name,
        "barcode": barcode,
        "chassisNumber": chassisNumber,
        "engineType": engineType,
        "numberPlate": numberPlate,
        "color": color,
        "notified": notified,
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
        type,
        scheme,
        barcode,
        chassisNumber,
        engineType,
        numberPlate,
        color,
        notified,
        locationId,
        userId,
      ];

  @override
  bool? get stringify => true;
}
