class UserModel {
  final String id;
  final String username;
  final String name;
  final String phone;
  final String email;
  final String? avatar;
  final int loves;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.phone,
    required this.email,
    this.avatar,
    required this.loves,
  });

  factory UserModel.fromJson(Map<String, dynamic> json)
  => UserModel(
    id: json["_id"],
    username: json["username"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"] ?? '',
    loves: json["loves"],
  );
}
