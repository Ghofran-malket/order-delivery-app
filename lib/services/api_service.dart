import 'dart:convert';
import 'package:algenie/data/models/user_model.dart';
import 'package:algenie/utils/auth_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final AuthStorage storage = AuthStorage();
  final String baseUrl = "http://192.168.1.89:3000/api/";

  //user login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      await storage.saveToken(data['token']);
      return data;
    }else {
      throw Exception('Login failed');
    }

  }

  //user register
  
  // "name": "customer",
  //   "email": "customer@gmail.com",
  //   "password": "customer",
  //   "role": "customer",
  //   "number": "2198984944984"
  Future<Map<String, dynamic>> register(User user) async {
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
    print("Code is" +response.statusCode.toString());

    if(response.statusCode == 201){
      final data = jsonDecode(response.body);
      await storage.saveToken(data['token']);
      return data;
    }else {
      throw Exception('Register failed');
    }

  }

}