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

  Future<List<Input>> addInput({
    required String token,
    required String name,
    required int quantity,
    required String unit,
    required String locationId,
    required String userId,
  }) async {
    final response = await inputProvider.addInput(
      token: token,
      name: name,
      quantity: quantity,
      locationId: locationId,
      unit: unit,
      userId: userId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => Input.fromJson(i),
        )
        .toList();
  }
}
