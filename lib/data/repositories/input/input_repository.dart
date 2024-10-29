import 'package:tisha_app/data/models/farmer_input.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/data/repositories/input/input_provider.dart';

class InputRepository {
  final InputProvider inputProvider;
  const InputRepository({required this.inputProvider});

  Future<List<Input>> getInputs() async {
    final response = await inputProvider.getInputs();

    return (response as List<dynamic>)
        .map(
          (i) => Input.fromJson(i),
        )
        .toList();
  }

  Future<List<FarmerInput>> getAllFarmerInputs({
    required String token,
  }) async {
    final response = await inputProvider.getAllFarmerInputs(
      token: token,
    );

    return (response as List<dynamic>)
        .map(
          (i) => FarmerInput.fromJson(i),
        )
        .toList();
  }

  Future<List<FarmerInput>> getFarmerInputs({
    required String token,
    required String userId,
  }) async {
    final response = await inputProvider.getFarmerInputs(
      token: token,
      userId: userId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => FarmerInput.fromJson(i),
        )
        .toList();
  }

  Future<List<Input>> addInput({
    required String token,
    required String name,
    required int quantity,
    required String? unit,
    required String type,
    required String scheme,
    required String barcode,
    required String? chassisNumber,
    required String? engineType,
    required String? numberPlate,
    required String? color,
    required String locationId,
    required String userId,
  }) async {
    final response = await inputProvider.addInput(
      token: token,
      name: name,
      quantity: quantity,
      locationId: locationId,
      unit: unit,
      type: type,
      scheme: scheme,
      barcode: barcode,
      chassisNumber: chassisNumber,
      engineType: unit,
      numberPlate: numberPlate,
      color: color,
      userId: userId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => Input.fromJson(i),
        )
        .toList();
  }

  Future<List<Input>> notifyInput({
    required String token,
    required String inputId,
  }) async {
    final response = await inputProvider.notifyInput(
      token: token,
      inputId: inputId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => Input.fromJson(i),
        )
        .toList();
  }

  Future<List<FarmerInput>> addFarmerInput({
    required String token,
    required String inputId,
    required String userId,
    required int quantity,
  }) async {
    final response = await inputProvider.addFarmerInput(
      token: token,
      inputId: inputId,
      quantity: quantity,
      userId: userId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => FarmerInput.fromJson(i),
        )
        .toList();
  }

  Future<List<FarmerInput>> updateFarmerInput({
    required String token,
    required String userId,
    required String inputId,
    required bool received,
    required double payback,
  }) async {
    final response = await inputProvider.updateFarmerInput(
      token: token,
      userId: userId,
      inputId: inputId,
      received: received,
      payback: payback,
    );

    return (response as List<dynamic>)
        .map(
          (i) => FarmerInput.fromJson(i),
        )
        .toList();
  }
}
