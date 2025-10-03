import 'package:algenie/data/models/user_model.dart';
import 'package:algenie/services/api_service.dart';
import 'package:algenie/utils/auth_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthStorage _storage = AuthStorage();
  final AuthService _apiService = AuthService();

  bool _isLoggedIn = false;
  String? _token;
  bool? _isOnline = false;
  
  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;
  bool? get isOnline => _isOnline;

  loadToken() async{
    _token = await _storage.getToken();
    _isLoggedIn = _token != null ;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final data = await _apiService.login(email, password);
    _token = data['token'];
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> register(User user) async {
    final data = await _apiService.register(user);
    _token = data['token'];
    _isLoggedIn = true;
    notifyListeners();
  }

  checkOnlineStatus() async{
    _isOnline = await _storage.getIsOnline() ?? false;
    notifyListeners();
  }

  Future<void> goOnline() async {
    final userId = await _storage.getUserId();
    final token = await _storage.getToken();

    try {
      await _apiService.goOnline(userId! , token!);
      _isOnline = true;
    } catch (e) {
      //_error = e.toString();
      print(e.toString());
    }
    notifyListeners();
  }
}