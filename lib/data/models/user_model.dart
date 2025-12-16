class User {
  String? id;
  String name;
  String email;
  String password;
  String role;
  String number;
  String? token;
  String? image;
  String? city;
  String? country;
  String? bio;
  int? likeCount;
  int? disLikeCount;
  List<String>? languages;

  User({this.id, required this.name, required this.email, required this.password, required this.role, 
  required this.number,this.token, this.image, this.city, this.country, this.bio, this.likeCount, this.disLikeCount, this.languages});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      number: json['number'] ?? '',
      token: json['token'] ?? '',
      image: json['imagePath'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      bio: json['bio'] ?? '',
      likeCount: json['likeCount'] ?? 0,
      disLikeCount: json['disLikeCount'] ?? 0,
      languages: List<String>.from(json['languages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'number': number,
      'token': token
    };
  }
}