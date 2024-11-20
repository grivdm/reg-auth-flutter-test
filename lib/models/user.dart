class User {
  final String email;
  final String name;
  final String hashPassword;

  User({required this.email, required this.hashPassword, required this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(
      email: json['email'],
      hashPassword: json['hashPassword'],
      name: json['name']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['hashPassword'] = hashPassword;
    data['name'] = name;

    return data;
  }
}
