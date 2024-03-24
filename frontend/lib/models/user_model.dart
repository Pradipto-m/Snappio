class UserModel {
  final String id;
  final String username;
  final String name;
  final String phone;
  final String email;
  final String? image;
  final int ver;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.phone,
    required this.email,
    this.image,
    required this.ver,
  });

  factory UserModel.fromJson(Map<String, dynamic> json)
  => UserModel(
    id: json["_id"],
    username: json["username"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"] ?? '',
    ver: json["__v"],
  );
}
