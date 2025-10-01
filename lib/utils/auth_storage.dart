import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _userId = 'userId';

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> saveToken(token) async{
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteToken() async{
    await _storage.delete(key: _tokenKey);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: _userId);
  }

  Future<void> saveUserId(userId) async{
    await _storage.write(key: _userId, value: userId);
  }

}