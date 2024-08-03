import 'package:tisha_app/data/models/farmer_input.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/user/user_provider.dart';

class UserRepository {
  final UserProvider userProvider;
  const UserRepository({required this.userProvider});

  Future<User> updateUserDetails({
    required String token,
    required User user,
  }) async {
    final response = await userProvider.updateUserDetails(
      token: token,
      user: user,
    );

    return User.fromJson(response);
  }

  Future<User> updateUserInputs({
    required String token,
    required String id,
    required List<FarmerInput> inputs,
  }) async {
    final response = await userProvider.updateUserInputs(
      token: token,
      id: id,
      inputs: inputs,
    );

    return User.fromJson(response);
  }
}
