part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();
  @override
  List<Object?> get props => [];
}

class LoadPerson extends PersonEvent {
  final String id;

  const LoadPerson({
    required this.id,
  });
}

class SearchPerson extends PersonEvent {
  final String userId;
  final String? query;
  final String? locationId;

  const SearchPerson({
    this.query,
    this.locationId,
    required this.userId,
  });
}

class LoadPeople extends PersonEvent {}

class AddPersonEvent extends PersonEvent {
  final String firstname;
  final String? lastname;
  final DateTime? dob;
  final String? gender;
  final String? role;
  final String? phone;
  final String? address;
  final String? nationalId;
  //farmer details
  final double? farmSize;
  final String? coordinates;
  final String locationId;
  final String? landOwnership;
  final String? farmerType;
  final String? cropType;
  final String? livestockType;
  final int? livestockNumber;
  final String email;
  final String password;

  const AddPersonEvent({
    required this.firstname,
    this.lastname,
    this.dob,
    this.gender,
    this.role,
    this.phone,
    this.address,
    this.nationalId,
    required this.farmSize,
    this.coordinates,
    required this.locationId,
    this.landOwnership,
    this.farmerType,
    this.cropType,
    this.livestockType,
    this.livestockNumber,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        firstname,
        lastname,
        dob,
        gender,
        role,
        phone,
        address,
        nationalId,
        farmSize,
        coordinates,
        locationId,
        landOwnership,
        farmerType,
        cropType,
        livestockType,
        livestockNumber,
        email,
        password,
      ];

  @override
  bool? get stringify => true;
}
