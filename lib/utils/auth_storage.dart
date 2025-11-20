import 'dart:convert';

import 'package:algenie/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _userId = 'userId';
  static const _isOnline = 'is_online';
  static const _user = 'user';

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
  Future<void> deleteUserId() async{
    await _storage.delete(key: _userId);
  }

  Future<bool?> getIsOnline() async {
    final value = await _storage.read(key: _isOnline);
    return value == 'true';
  }

  Future<void> saveIsOnline(isOnline) async{
    await _storage.write(key: _isOnline, value: isOnline);
  }

  Future<User?> getUser() async {
    final userJson = await _storage.read(key: _user);
    if (userJson == null) return null;
    return User.fromJson(jsonDecode(userJson!));
  }

  Future<void> saveUser(User user) async{
    await _storage.write(key: _user, value: jsonEncode(user.toJson()));
  }

  Future<void> deleteUser() async{
    await _storage.delete(key: _user);
  }

}