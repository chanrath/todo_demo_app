class User {
  final String id;
  final String email;
  final String jwt;

  User({required this.id, required this.email, required this.jwt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['user']['id'].toString(),
        email: json['user']['email'],
        jwt: json['user']['jwt']);
  }
}