import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/farmer/farmer_provider.dart';

class FarmerRepository {
  final FarmerProvider farmerProvider;
  const FarmerRepository({required this.farmerProvider});

  Future<List<User>> getFarmers({
    required String token,
    String? query,
  }) async {
    final response = await farmerProvider.getFarmers(
      token: token,
      query: query,
    );

    return (response as List<dynamic>)
        .map(
          (i) => User.fromJson(i),
        )
        .toList();
  }

  Future<List<User>> addFarmer({
    required String token,
    required String name,
    String? surname,
    DateTime? dob,
    int? age,
    String? gender,
    String? phone,
    String? address,
    String? nationalId,
    required double farmSize,
    required String locationId,
    String? coordinates,
    String? landOwnership,
    String? farmerType,
    String? cropType,
    String? livestockType,
    int? livestockNumber,
    required String email,
    required String password,
  }) async {
    final response = await farmerProvider.addFarmer(
      token: token,
      name: name,
      surname: surname,
      dob: dob,
      age: age,
      gender: gender,
      phone: phone,
      address: address,
      nationalId: nationalId,
      landOwnership: landOwnership,
      farmerType: farmerType,
      cropType: cropType,
      livestockType: livestockType,
      livestockNumber: livestockNumber,
      farmSize: farmSize,
      locationId: locationId,
      coordinates: coordinates,
      email: email,
      password: password,
    );

    return (response as List<dynamic>)
        .map(
          (i) => User.fromJson(i),
        )
        .toList();
  }

  Future<User> getFarmer({
    required String token,
    required String id,
    String? query,
  }) async {
    final response = await farmerProvider.getFarmer(
      token: token,
      id: id,
      query: query,
    );

    return User.fromJson(response);
  }
}
