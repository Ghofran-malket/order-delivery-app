class Item {
  String title;
  String description;
  String image;
  String price;
  String category;
  String storeId;

  Item({required this.title, required this.description, required this.image, 
  required this.price, required this.category, required this.storeId});


  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'] ,
      description: json['description'],
      image: json['image'],
      price: json['price'],
      category: json['category'],
      storeId: json['store']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'category': category,
      'store': storeId
    };
  }
}