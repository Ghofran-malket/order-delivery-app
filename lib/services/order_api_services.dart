import 'dart:convert';
import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/data/models/report_model.dart';
import 'package:algenie/utils/auth_storage.dart';
import 'package:http/http.dart' as http;

class OrderApiService {
  final String baseUrl = "http://192.168.1.89:3000/api/";
  final AuthStorage storage = AuthStorage();

  //get orders
  Stream<List<Order>> getTakenOrders() async* {
    final genieId = await storage.getUserId();
    final response = await http.get(
      Uri.parse('${baseUrl}orders/getTakenOrders/?genieId=$genieId'),
      headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      final List<Order> orders = data.map((e) => Order.fromJson(e)).toList();
      yield orders;
    } else {
      yield [];
    }

  }

  Future<Order?> getOrderById(String orderId) async {
    final response = await http.get(
      Uri.parse('${baseUrl}orders/getOrderById/?orderId=$orderId'),
      headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> orderJson = jsonDecode(response.body);
      return Order.fromJson(orderJson);
    } else {
      return null;
    }

  }

  Future updateStoreStatus(String orderId, String storeId) async {
    final response = await http.put(
      Uri.parse('${baseUrl}orders/updateStoreStatus/?orderId=$orderId&&storeId=$storeId'),
      headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      print('good');
    } else {
      print('bad');
    }
  }

  Future<Order?> updateOrderReceiptValue(String orderId, String receiptValue) async {
    final response = await http.put(
      Uri.parse('${baseUrl}orders/updateOrder/?orderId=$orderId&&receiptValue=$receiptValue'),
      headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> orderJson = jsonDecode(response.body);
      return Order.fromJson(orderJson);
    } else {
      return null;
    }
  }

  Future<Order?> updateOrderStatus(String orderId, String orderStatus) async {
    final response = await http.put(
      Uri.parse('${baseUrl}orders/updateOrderStatus/?orderId=$orderId&&orderStatus=$orderStatus'),
      headers: {'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> orderJson = jsonDecode(response.body);
      return Order.fromJson(orderJson);
    } else {
      return null;
    }
  }

  Future report(Report report) async {
    final genieId = await storage.getUserId();

    final response = await http.post(
      Uri.parse('${baseUrl}reports/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'orderId': report.orderId,
        'genieId':  genieId,
        'customerId':  report.customerId,
        'reports':  report.reports,
        'description':  report.description}),
    );

    if(response.statusCode == 201){
      final data = jsonDecode(response.body);
      return Report.fromJson(data);
    }else {
      throw Exception('Report failed');
    }

  }
}