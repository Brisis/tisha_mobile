import 'dart:convert';

import 'package:equatable/equatable.dart';

class Input extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;

  const Input({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  String toRawJson() => json.encode(toJson());

  Input.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        imageUrl = json["imageUrl"] == null ? null : json["imageUrl"] as String;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
      ];

  @override
  bool? get stringify => true;
}
