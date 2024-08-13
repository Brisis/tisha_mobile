import 'package:equatable/equatable.dart';
import 'package:tisha_app/data/models/enums.dart';
import 'package:tisha_app/data/models/farmer_input.dart';
import 'package:tisha_app/data/models/feedback.dart';
import 'package:tisha_app/data/models/input_application.dart';
import 'dart:convert';

import 'package:tisha_app/data/models/location.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? surname;
  final DateTime? dob;
  final int? age;
  final Gender? gender;
  final String? phone;
  final String? address;
  final String? nationalId;
  final String role;

  //farm details
  final double? farmSize;
  final String? locationId;
  final String? coordinates;
  final OwnerShip? landOwnership;
  final FarmerType? farmerType;
  final CropType? cropType;
  final LiveStockType? livestockType;
  final int? livestockNumber;
  //login
  final String email;
  final bool? emailVerified;
  final String password;

  //add-ons
  final List<FarmerInput> inputs;
  final Location? location;
  final List<Feedback> feedback;
  final List<UserInputApplication> applications;
  const User({
    required this.id,
    required this.name,
    required this.role,
    this.surname,
    this.dob,
    this.age,
    this.gender,
    this.phone,
    this.address,
    this.nationalId,
    //farm
    this.farmSize,
    this.locationId,
    this.location,
    this.coordinates,
    this.landOwnership,
    this.farmerType,
    this.cropType,
    this.livestockType,
    this.livestockNumber,
    //auth
    required this.email,
    this.emailVerified,
    required this.password,
    //add-ons
    required this.inputs,
    required this.feedback,
    required this.applications,
  });

  User copyWith({
    String? name,
    String? role,
    String? surname,
    DateTime? dob,
    int? age,
    Gender? gender,
    String? phone,
    String? address,
    String? nationalId,
    //farm
    double? farmSize,
    String? locationId,
    String? coordinates,
    OwnerShip? landOwnership,
    FarmerType? farmerType,
    CropType? cropType,
    LiveStockType? livestockType,
    int? livestockNumber,
    //auth
    String? email,
    String? password,
    //add-ons
    List<FarmerInput>? inputs,
    Location? location,
    List<Feedback>? feedback,
    List<UserInputApplication>? applications,
  }) =>
      User(
        id: id,
        name: name ?? this.name,
        role: role ?? this.role,
        surname: surname ?? this.surname,
        dob: dob ?? this.dob,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        nationalId: nationalId ?? this.nationalId,
        //farm
        farmSize: farmSize ?? this.farmSize,
        locationId: locationId ?? this.locationId,
        coordinates: coordinates ?? this.coordinates,
        landOwnership: landOwnership ?? this.landOwnership,
        farmerType: farmerType ?? this.farmerType,
        cropType: cropType ?? this.cropType,
        livestockType: livestockType ?? this.livestockType,
        livestockNumber: livestockNumber ?? this.livestockNumber,
        //auth
        email: email ?? this.email,
        emailVerified: emailVerified,
        password: password ?? this.password,
        //add-ons
        inputs: inputs ?? this.inputs,
        location: location ?? this.location,
        feedback: feedback ?? this.feedback,
        applications: applications ?? this.applications,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        surname: json["surname"] == null ? null : json["surname"] as String,
        dob:
            json["dob"] == null ? null : DateTime.parse(json["dob"].toString()),
        age: json["age"] == null ? null : int.parse(json["age"].toString()),
        gender: json["gender"] == null
            ? null
            : Gender.values
                .firstWhere((value) => value.name == json["gender"].toString()),
        phone: json["phone"] == null ? null : json["phone"] as String,
        address: json["address"] == null ? null : json["address"] as String,
        nationalId:
            json["nationalId"] == null ? null : json["nationalId"] as String,
        farmSize: json["farmSize"] == null
            ? null
            : double.parse(json["farmSize"].toString()),
        locationId:
            json["locationId"] == null ? null : json["locationId"] as String,
        coordinates:
            json["coordinates"] == null ? null : json["coordinates"] as String,
        landOwnership: json["landOwnership"] == null
            ? null
            : OwnerShip.values.firstWhere(
                (value) => value.name == json["landOwnership"].toString()),
        farmerType: json["farmerType"] == null
            ? null
            : FarmerType.values.firstWhere(
                (value) => value.name == json["farmerType"].toString()),
        cropType: json["cropType"] == null
            ? null
            : CropType.values.firstWhere(
                (value) => value.name == json["cropType"].toString()),
        livestockType: json["livestockType"] == null
            ? null
            : LiveStockType.values.firstWhere(
                (value) => value.name == json["livestockType"].toString()),
        livestockNumber: json["livestockNumber"] == null
            ? null
            : int.parse(json["livestockNumber"].toString()),
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
        feedback: json["feedback"] == null
            ? []
            : (json["feedback"] as List<dynamic>)
                .map((i) => Feedback.fromJson(i))
                .toList(),
        applications: json["applications"] == null
            ? []
            : (json["applications"] as List<dynamic>)
                .map((i) => UserInputApplication.fromJson(i))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "surname": surname,
        "dob": dob?.toIso8601String(),
        "age": age,
        "gender": gender,
        "phone": phone,
        "address": address,
        "nationalId": nationalId,
        "farmSize": farmSize,
        "locationId": locationId,
        "coordinates": coordinates,
        "landOwnership": landOwnership,
        "farmerType": farmerType,
        "cropType": cropType,
        "livestockType": livestockType,
        "livestockNumber": livestockNumber,
        "email": email,
        "emailVerified": emailVerified,
        "password": password,
        "inputs": List<dynamic>.from(inputs.map((x) => x.toJson())),
        "location": location!.toJson(),
        "feedback": List<dynamic>.from(feedback.map((x) => x.toJson())),
        "applications": List<dynamic>.from(applications.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        surname,
        dob,
        age,
        gender,
        phone,
        address,
        nationalId,
        //farm
        farmSize,
        locationId,
        coordinates,
        landOwnership,
        farmerType,
        cropType,
        livestockType,
        livestockNumber,
        //auth
        email,
        emailVerified,
        password,
        //add-ons
        inputs,
        location,
        feedback,
        applications,
      ];

  @override
  bool? get stringify => true;
}
