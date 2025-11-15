import 'dart:convert';
import 'package:algenie/data/models/user_model.dart';
import 'package:algenie/utils/auth_storage.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class AuthService {
  final AuthStorage storage = AuthStorage();
  final String baseUrl = "http://192.168.1.89:3000/api/";

  //user login
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      await storage.saveToken(data['token']);
      await storage.saveUserId(data['id']);
      await storage.saveUser(User.fromJson(data));
      return User.fromJson(data);
    }else {
      throw Exception('Login failed');
    }

  }

  //user register
  Future<User> register(User user) async {
    final response = await http.post(
      Uri.parse('${baseUrl}users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'role': user.role,
        'number': user.number}),
    );

    if(response.statusCode == 201){
      final data = jsonDecode(response.body);
      await storage.saveToken(data['token']);
      await storage.saveUserId(data['id']);
      await storage.saveUser(User.fromJson(data));
      return User.fromJson(data);
    }else {
      throw Exception('Register failed');
    }

  }

  Future<dynamic> inviteFriend() async {
    final userId = await storage.getUserId();
    final response = await http.get(
      Uri.parse('${baseUrl}users/invite-link/$userId'),
      headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final String link = data['inviteLink'];
      await SharePlus.instance.share(
        ShareParams(text: 'Join me on this app: $link')
      );
      
    }else {
      throw Exception('Failed to generate link');
    }

  }

  Future<dynamic> goOnline(String userId, String token, double lat, double long) async {
    final response = await http.post(
      Uri.parse('${baseUrl}genie/goOnline'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'token': token,
        'latitude': lat.toString(),
        'longitude': long.toString()}),
    );

    if(response.statusCode == 201){
      final data = jsonDecode(response.body);
      await storage.saveIsOnline('true');
      return data;
      
    }else {
      throw Exception('Failed to create an online genie document');
    }

  }

  Future<dynamic> goOffline(String userId) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}genie/goOffline/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      await storage.saveIsOnline('false');
      return data;
      
    }else {
      throw Exception('Failed to delete the online genie document');
    }

  }

  Future<User> getUserInfo(String userId) async {
    
    final response = await http.get(
      Uri.parse('${baseUrl}users/info/?userId=$userId'),
      headers: {'Content-Type': 'application/json'}
    );

    if(response.statusCode == 200){
      final Map<String, dynamic> userJson = jsonDecode(response.body);
      return User.fromJson(userJson);
    }else {
      throw Exception('Failed to get user iformation');
    }

  }
}