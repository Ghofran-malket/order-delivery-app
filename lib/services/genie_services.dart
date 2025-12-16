import 'dart:convert';
import 'package:algenie/core/constants/app_constants.dart';
import 'package:algenie/services/socket_services.dart';
import 'package:algenie/utils/auth_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GenieService {
  final generalStorage = FlutterSecureStorage();
  final AuthStorage storage = AuthStorage();
  final String baseUrl = "http://192.168.1.89:3000/api/";

  //genie accept order
  Future acceptOrder(String orderId) async {
    final userId = await storage.getUserId();
    final response = await http.put(
      Uri.parse('${baseUrl}genie/acceptOrder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'orderId': orderId}),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);

      //initilize the socket after the genie goes online to make hime able to send and receive msg from/to customer
      final socketService = SocketService();
      ChatId = userId! + orderId;
      socketService.init(ChatId);
      return data;
    }else {
      throw Exception('acceptOrder failed');
    }
  }

  //genie reject order
  Future rejectOrder(String orderId) async {
    final userId = await storage.getUserId();
    final response = await http.post(
      Uri.parse('${baseUrl}genie/rejectOrder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'orderId': orderId}),
    );

    if(response.statusCode == 201){
      final data = jsonDecode(response.body);
      return data;
    }else {
      throw Exception('rejectOrder failed');
    }
  }
}