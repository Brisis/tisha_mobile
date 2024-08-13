import 'package:tisha_app/data/models/input_application.dart';
import 'package:tisha_app/data/repositories/application/application_provider.dart';

class ApplicationRepository {
  final ApplicationProvider applicationProvider;
  const ApplicationRepository({required this.applicationProvider});

  Future<List<InputApplication>> getApplications() async {
    final response = await applicationProvider.getApplications();

    return (response as List<dynamic>)
        .map(
          (i) => InputApplication.fromJson(i),
        )
        .toList();
  }

  Future<List<InputApplication>> getFarmerApplications({
    required String token,
    required String userId,
  }) async {
    final response = await applicationProvider.getFarmerApplications(
      token: token,
      userId: userId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => InputApplication.fromJson(i),
        )
        .toList();
  }

  Future<List<InputApplication>> addApplication({
    required String token,
    required String name,
    required int quantity,
    required String unit,
    required String locationId,
    required String userId,
  }) async {
    final response = await applicationProvider.addApplication(
      token: token,
      name: name,
      quantity: quantity,
      locationId: locationId,
      unit: unit,
      userId: userId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => InputApplication.fromJson(i),
        )
        .toList();
  }

  Future<List<InputApplication>> addFarmerApplication({
    required String token,
    required String inputId,
    required String userId,
    required int quantity,
  }) async {
    final response = await applicationProvider.addFarmerApplication(
      token: token,
      inputId: inputId,
      quantity: quantity,
      userId: userId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => InputApplication.fromJson(i),
        )
        .toList();
  }

  Future<List<InputApplication>> updateFarmerApplication({
    required String token,
    required String userId,
    required String inputId,
    required bool received,
    required double payback,
  }) async {
    final response = await applicationProvider.updateFarmerApplication(
      token: token,
      userId: userId,
      inputId: inputId,
      received: received,
      payback: payback,
    );

    return (response as List<dynamic>)
        .map(
          (i) => InputApplication.fromJson(i),
        )
        .toList();
  }
}
