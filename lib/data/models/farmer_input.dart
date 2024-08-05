import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tisha_app/data/models/input.dart';

class FarmerInput extends Equatable {
  final String id;
  final String userId;
  final bool received;
  final double? payback;
  final Input input;

  const FarmerInput({
    required this.id,
    required this.userId,
    required this.received,
    this.payback,
    required this.input,
  });

  String toRawJson() => json.encode(toJson());

  FarmerInput.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        received = json["received"],
        payback = json["payback"] == null
            ? null
            : double.parse(json["payback"].toString()),
        input = Input.fromJson(json["input"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "received": received,
        "payback": payback,
        "input": input.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        received,
        payback,
        input,
      ];

  @override
  bool? get stringify => true;
}
