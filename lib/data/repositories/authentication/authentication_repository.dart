import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/authentication/authentication_provider.dart';

class AuthenticationRepository {
  final AuthenticationProvider authenticationProvider;
  const AuthenticationRepository({required this.authenticationProvider});

  Future<dynamic> register({
    required String phone,
    required String fcmToken,
  }) async {
    final response = await authenticationProvider.register(
      phone: phone,
      fcmToken: fcmToken,
    );

    return response;
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await authenticationProvider.login(
      email: email,
      password: password,
    );

    return response["access_token"];
  }

  Future<User> authenticate({
    required String token,
  }) async {
    final response = await authenticationProvider.authenticate(
      token: token,
    );

    return User.fromJson(response);
  }
}
