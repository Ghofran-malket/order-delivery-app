import 'package:algenie/data/models/item_model.dart';
import 'package:geolocator/geolocator.dart';

class Store {
  String id;
  String name;
  String title;
  List<Item> items;
  Position? location;
  String storeStatus;



  Store({required this.id, required this.name, required this.title, required this.items, required this.location, required this.storeStatus});


  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      items: (json['items'] as List).map((itemJson) => Item.fromJson(itemJson)).toList(),
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