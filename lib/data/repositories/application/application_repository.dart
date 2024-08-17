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

  Future<List<InputApplication>> acceptApplication({
    required String token,
    required double quantity,
    required String inputId,
    required String applicationId,
    required String userId,
  }) async {
    final response = await applicationProvider.acceptApplication(
      token: token,
      quantity: quantity,
      inputId: inputId,
      userId: userId,
      applicationId: applicationId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => InputApplication.fromJson(i),
        )
        .toList();
  }

  Future<List<InputApplication>> rejectApplication({
    required String token,
    required String applicationId,
  }) async {
    final response = await applicationProvider.rejectApplication(
      token: token,
      applicationId: applicationId,
    );

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
    required String inputId,
    required String userId,
    required String message,
    required double quantity,
  }) async {
    final response = await applicationProvider.addApplication(
      token: token,
      inputId: inputId,
      message: message,
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
