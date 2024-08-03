import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

// to save token in local storage
void saveAuthToken(String token) async {
  await storage.write(key: 'token', value: token);
}

// to save userId in local storage
void saveUserId(String userId) async {
  await storage.write(key: 'userId', value: userId);
}

// to delete token in local storage
void deleteAuthToken() async {
  await storage.delete(key: 'token');
}

// to delete userId in local storage
void deleteUserId() async {
  await storage.delete(key: 'userId');
}

Future<String?> getAuthToken() async {
// to get token from local storage
  final token = await storage.read(key: 'token');
  return token;
}

Future<String?> getUserId() async {
// to get userId from local storage
  final userId = await storage.read(key: 'userId');
  return userId;
}
