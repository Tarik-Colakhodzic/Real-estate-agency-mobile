class User {
  final int id;
  final String username;

  User({required this.id, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: int.parse(json["id"].toString()), username: json["username"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "username": username};
}