import 'package:algenie/data/models/store_model.dart';
import 'package:geolocator/geolocator.dart';

class Order {
  String genieId;
  String orderId;
  String customerId;
  String orderStatus;
  List<Store> stores;
  DateTime? createdAt;
  Position? orderLocation;
  DateTime? updatedAt;
  String totalReceiptValue;
  Map<String, dynamic> genieProgress;

  Order({required this.genieId, required this.orderId, required this.customerId, required this.stores, required this.orderStatus,
   this.createdAt, required this.totalReceiptValue, this.orderLocation, required this.genieProgress});


  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      genieId: json['genieId'] ,
      orderId: json['orderId'],
      customerId: json['customerId'],
      stores: (json['stores'] as List).map( (storeJson) => Store.fromJson(storeJson)).toList(),
      orderStatus: json['orderStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      totalReceiptValue: json['receiptValue'],
      orderLocation: Position(
        longitude: json['orderLocation']['longitude'],
        latitude: json['orderLocation']['latitude'],
        accuracy: 0.0,
        timestamp: DateTime.now(),
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      ),
      genieProgress: json['genieProgress']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genieId': genieId,
      'orderId': orderId,
      'customerId': customerId,
      'stores': stores.map((store)=> store.toJson()).toList(),
      'orderStatus': orderStatus,
      'createdAt': createdAt,
      'receiptValue': totalReceiptValue
    };
  }
}