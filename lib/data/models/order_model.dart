import 'dart:convert';

import 'package:algenie/data/models/order_store_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Order {
  String genieId;
  String orderId;
  String customerId;
  String orderStatus;
  List<OrderStore> stores;
  DateTime? createdAt;
  Position? orderLocation;
  DateTime? updatedAt;
  String totalReceiptValue;
  Map<String, dynamic> genieProgress;

  Order({required this.genieId, required this.orderId, required this.customerId, required this.stores, required this.orderStatus,
   this.createdAt, this.updatedAt, required this.totalReceiptValue, this.orderLocation, required this.genieProgress});


  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      genieId: json['genieId'] ,
      orderId: json['orderId'],
      customerId: json['customerId'],
      stores: (json['stores'] as List).map( (storeJson) => OrderStore.fromJson(storeJson)).toList(),
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
      updatedAt: DateTime.parse(json['updatedAt']),
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
      'receiptValue': totalReceiptValue,
      'updatedAt': updatedAt
    };
  }

  factory Order.fromFirebaseNotification(Map<String, dynamic> data) {
    final format = DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z");
    return Order(
      genieId: data['genieId'] ,
      orderId: data['orderId'],
      customerId: data['customerId'],
      stores: (jsonDecode(data['stores']) as List).map( (storeJson) => OrderStore.fromJson(storeJson)).toList(),
      orderStatus: data['orderStatus'],
      createdAt: format.parse(data['createdAt'].split(' (')[0]),
      totalReceiptValue: data['receiptValue'],
      orderLocation: Position(
        longitude: double.parse(data['orderLocationLongitude']),
        latitude:  double.parse(data['orderLocationLatitude']),
        accuracy: 0.0,
        timestamp: DateTime.now(),
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      ),
      genieProgress: {
        'storeIndex' : int.parse(data['genieProgressStoreIndex']),
        'step' : data['genieProgressStep'],
        'lastUpdated' :format.parse(data['genieProgressLastUpdated'].split(' (')[0]),
      }
    );
  }

}