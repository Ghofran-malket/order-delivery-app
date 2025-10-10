import 'package:geolocator/geolocator.dart';

class Order {
  String genieId;
  String orderId;
  String customerId;
  String orderStatus;
  DateTime? createdAt;
  Position? orderLocation;
  DateTime? updatedAt;

  Order({required this.genieId, required this.orderId, required this.customerId, required this.orderStatus});


  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      genieId: json['genieId'] ,
      orderId: json['orderId'],
      customerId: json['customerId'],
      orderStatus: json['orderStatus']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genieId': genieId,
      'orderId': orderId,
      'customerId': customerId,
      'orderStatus': orderStatus
    };
  }
}