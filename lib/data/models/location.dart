import 'dart:convert';

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final String name;
  final String city;

  const Location({
    required this.id,
    required this.name,
    required this.city,
  });

  Location copyWith({
    String? id,
    String? name,
    String? city,
  }) =>
      Location(
        id: id ?? this.id,
        name: name ?? this.name,
        city: city ?? this.city,
      );

  String toRawJson() => json.encode(toJson());

  Location.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        city = json["city"] as String;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        city,
      ];

  @override
  bool? get stringify => true;
}
