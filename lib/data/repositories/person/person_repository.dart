import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/person/person_provider.dart';

class PersonRepository {
  final PersonProvider personProvider;
  const PersonRepository({required this.personProvider});

  Future<List<User>> getPeople({
    required String token,
    String? query,
  }) async {
    final response = await personProvider.getPeople(
      token: token,
      query: query,
    );

    return (response as List<dynamic>)
        .map(
          (i) => User.fromJson(i),
        )
        .toList();
  }

  Future<List<User>> addPerson({
    required String token,
    required String firstname,
    String? lastname,
    DateTime? dob,
    int? age,
    String? gender,
    String? role,
    String? phone,
    String? address,
    String? nationalId,
    double? farmSize,
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
    final response = await personProvider.addPerson(
      token: token,
      firstname: firstname,
      lastname: lastname,
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
      role: role,
      email: email,
      password: password,
    );

    return (response as List<dynamic>)
        .map(
          (i) => User.fromJson(i),
        )
        .toList();
  }

  Future<User> getPerson({
    required String token,
    required String id,
    String? query,
  }) async {
    final response = await personProvider.getPerson(
      token: token,
      id: id,
      query: query,
    );

    return User.fromJson(response);
  }
}
