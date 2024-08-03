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
}
