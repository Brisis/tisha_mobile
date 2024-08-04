import 'package:equatable/equatable.dart';
import 'package:tisha_app/data/models/farmer_input.dart';
import 'dart:convert';

import 'package:tisha_app/data/models/location.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String role;
  final double? farmSize;
  final String? locationId;
  final String? coordinates;
  final String email;
  final bool? emailVerified;
  final String password;
  final List<FarmerInput> inputs;
  final Location? location;
  const User({
    required this.id,
    required this.name,
    required this.role,
    this.farmSize,
    this.locationId,
    this.location,
    this.coordinates,
    required this.email,
    this.emailVerified,
    required this.password,
    required this.inputs,
  });

  User copyWith({
    String? name,
    String? role,
    double? farmSize,
    String? locationId,
    String? coordinates,
    String? email,
    String? password,
    List<FarmerInput>? inputs,
    Location? location,
  }) =>
      User(
        id: id,
        name: name ?? this.name,
        role: role ?? this.role,
        farmSize: farmSize ?? this.farmSize,
        locationId: locationId ?? this.locationId,
        coordinates: coordinates ?? this.coordinates,
        email: email ?? this.email,
        emailVerified: emailVerified,
        password: password ?? this.password,
        inputs: inputs ?? this.inputs,
        location: location ?? this.location,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        farmSize: json["farmSize"] == null
            ? null
            : double.parse(json["farmSize"].toString()),
        locationId:
            json["locationId"] == null ? null : json["locationId"] as String,
        coordinates:
            json["coordinates"] == null ? null : json["coordinates"] as String,
        email: json["email"],
        emailVerified: json["emailVerified"],
        password: json["password"],
        inputs: json["inputs"] == null
            ? []
            : (json["inputs"] as List<dynamic>)
                .map((i) => FarmerInput.fromJson(i))
                .toList(),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "farmSize": farmSize,
        "locationId": locationId,
        "coordinates": coordinates,
        "email": email,
        "emailVerified": emailVerified,
        "password": password,
        "inputs": List<dynamic>.from(inputs.map((x) => x.toJson())),
        "location": location!.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        farmSize,
        locationId,
        coordinates,
        email,
        emailVerified,
        password,
        inputs,
        location,
      ];

  @override
  bool? get stringify => true;
}
