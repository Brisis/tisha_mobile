part of 'farmer_bloc.dart';

abstract class FarmerEvent extends Equatable {
  const FarmerEvent();
  @override
  List<Object?> get props => [];
}

class LoadFarmer extends FarmerEvent {
  final String id;

  const LoadFarmer({
    required this.id,
  });
}

class SearchFarmer extends FarmerEvent {
  final String userId;
  final String? query;
  final String? locationId;

  const SearchFarmer({
    this.query,
    this.locationId,
    required this.userId,
  });
}

class LoadFarmers extends FarmerEvent {}

class AddFarmerEvent extends FarmerEvent {
  final String name;
  final String? surname;
  final DateTime? dob;
  final String? gender;
  final String? phone;
  final String? address;
  final String? nationalId;
  final double farmSize;
  final String? coordinates;
  final String locationId;
  final String? landOwnership;
  final String? farmerType;
  final String? cropType;
  final String? livestockType;
  final int? livestockNumber;
  final String email;
  final String password;

  const AddFarmerEvent({
    required this.name,
    this.surname,
    this.dob,
    this.gender,
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
        name,
        surname,
        dob,
        gender,
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
