class User {
  final int id;
  final String username;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmedPassword;
  String? fullName;
  List<int>? roles;

  User(
      {required this.id,
      required this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.password,
      this.confirmedPassword,
      this.roles,
      this.fullName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: int.parse(json["id"].toString()), username: json["username"], fullName: json["fullName"]);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmedPassword": confirmedPassword,
        "roles": roles
      };
}
