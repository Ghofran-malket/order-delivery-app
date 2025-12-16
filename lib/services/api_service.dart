import 'dart:convert';
import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/data/models/user_model.dart';
import 'package:algenie/services/socket_services.dart';
import 'package:algenie/utils/auth_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class AuthService {
  final generalStorage = FlutterSecureStorage();
  final AuthStorage storage = AuthStorage();
  final String baseUrl = "http://192.168.1.89:3000/api/";

  //user login
  Future<User> login(String email, String password) async {
    String? fcmToken = await generateFCMToken();
    final response = await http.post(
      Uri.parse('${baseUrl}users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password, 'token': fcmToken}),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      await storage.saveToken(data['token']);
      await storage.saveUserId(data['_id']);
      await storage.saveUser(User.fromJson(data));
      if(data['role'] == 'genie'){
        await isOnline(data['_id']);
      }
      return User.fromJson(data);
    }else {
      throw Exception('Login failed');
    }

  }

  //user register
  Future<User> register(User user) async {
    String? fcmToken = await generateFCMToken();
    final response = await http.post(
      Uri.parse('${baseUrl}users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'role': user.role,
        'number': user.number,
        'city': user.city,
        'country': user.country,
        'bio': user.bio,
        'imagePath': user.image,
        'token': fcmToken
        }),
    );

    if(response.statusCode == 201){
      final data = jsonDecode(response.body);
      await storage.saveToken(data['token']);
      await storage.saveUserId(data['_id']);
      await storage.saveUser(User.fromJson(data));
      return User.fromJson(data);
    }else {
      throw Exception('Register failed');
    }

  }

  //user logout
  Future<void> logout() async {
    try{
      await storage.deleteToken();
      await storage.deleteUserId();
      await storage.deleteUser();
      await generalStorage.deleteAll();
      SocketService().dispose();
    }catch(e){
      throw Exception(e.toString());
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

  Future<dynamic> isOnline(String userId) async {
    final response = await http.get(
      Uri.parse('${baseUrl}genie/isOnline/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      bool isOnline = data['isOnline'];
      await storage.saveIsOnline(isOnline.toString());
    }else {
      await storage.saveIsOnline('false');
      throw Exception('Failed to test if genie is online or not');
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

  Future loadUserStatus() async {
    try{
      final user = await storage.getUser();
      final userId = await storage.getUserId();
      final role = user?.role;

      if(role == 'genie'){
        final data = await getGenieCurrentOrder(userId!);
        //genie with order
        if(data['active']){
          return {
            "role" : role,
            "active" : data['active'],
            "order" : data['order']
          }; 
        }
        //genie with no order
        return {
          "role" : role,
          "active" : data['active'],
        }; 
        
      }else{
        //Customer
        return {
          "role" : role
        };
      }
      
    }catch(e){
      throw Exception("Failed to load user status ${e.toString()}");
    }
  }

  Future<User> giveRating(String customerId, int ratingValue) async {
    final response = await http.put(
      Uri.parse('${baseUrl}users/rate/?customerId=$customerId&&rating=$ratingValue'),
      headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> userJson = jsonDecode(response.body);
      return User.fromJson(userJson);
    } else {
      throw Exception('Failed to rating');
    }
  }

  Future getGenieCurrentOrder(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}orders/genie/current/?genieId=$userId'),
        headers: {'Content-Type': 'application/json'}
      );
      if(response.statusCode == 200){
        final Map<String, dynamic> data = jsonDecode(response.body);
        //if active is true then there is a taken order by this genie
        if(data['active']){
          final Map<String,dynamic> orderMap = data['order'];
          final Order order = Order.fromJson(orderMap);
          return {
            'active': data['active'],
            'order': order 
          };
        }
        //No taken order
        return {
          'active': data['active'],
        };
      }
    } catch (e) {
      throw Exception('Failed to getGenieCurrentOrder');
    }
  }

  Future updateGenieProgress({required String orderId, required String  step, int? storeIndex = -1}) async {
    try {
      final response = await http.put(
        Uri.parse('${baseUrl}orders/progress/?orderId=$orderId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'step': step,
          'storeIndex': storeIndex}),
      );
      if(response.statusCode == 201){
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'success': data['success'],
          'progress': data['progress']
        };
      }
    } catch (e) {
      throw Exception('Failed to updateGenieProgress');
    }
  }

  Future<String?> generateFCMToken() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permissions
    await messaging.requestPermission();

    // Get FCM token
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // Send token to your backend
    return token;
  }

  Future sendNotification() async{
    final userId = await storage.getUserId();

    final response =  await http.post(
      Uri.parse('${baseUrl}users/sendNotification'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId}),
    );
    if(response.statusCode == 201){
      final data = jsonDecode(response.body);
      print('data $data');
    }else {
      throw Exception('sendnotification failed');
    }
  }
}