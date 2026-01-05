import 'package:algenie/data/models/order_item_model.dart';
import 'package:geolocator/geolocator.dart';

class OrderStore {
  String id;
  String name;
  String title;
  List<OrderItem> items;
  Position? location;
  String storeStatus;



  OrderStore({required this.id, required this.name, required this.title, required this.items, required this.location, required this.storeStatus});


  factory OrderStore.fromJson(Map<String, dynamic> json) {
    return OrderStore(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      items: (json['items'] as List).map((itemJson) => OrderItem.fromJson(itemJson)).toList(),
      location: Position(
        longitude: json['storeLocation']['longitude'],
        latitude: json['storeLocation']['latitude'],
        accuracy: 0.0,
        timestamp: DateTime.now(),
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      ),
      storeStatus: json['storeStatus']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'title': title,
      'items': items.map((item) => item.toJson()).toList(),
      'storeStatus': storeStatus,
      'storeLocation.longitude': location?.longitude,
      'storeLocation.latitude': location?.latitude
    };
  }
}