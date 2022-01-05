class User {
  final int id;
  final String username;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmedPassword;

  User(
      {required this.id,
      required this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.password,
      this.confirmedPassword});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: int.parse(json["id"].toString()), username: json["username"]);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmedPassword": confirmedPassword
      };
}
