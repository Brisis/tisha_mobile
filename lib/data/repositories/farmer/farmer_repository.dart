import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/farmer/farmer_provider.dart';

class FarmerRepository {
  final FarmerProvider farmerProvider;
  const FarmerRepository({required this.farmerProvider});

  Future<List<User>> getFarmers({
    required String token,
    required String userId,
    String? query,
  }) async {
    final response = await farmerProvider.getFarmers(
      token: token,
      userId: userId,
      query: query,
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
