import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Role.dart';
import 'package:real_estate_mobile/models/User.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmedPasswordController =
      new TextEditingController();
  var result = null;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(60),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Ime'),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Ime je obavezno!';
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Prezime'),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Prezime je obavezno!';
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Korisničko ime'),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Korisničko ime je obavezno!';
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Email je obavezan!';
                      if (!isEmailValid(value))
                        return 'Email nije u ispravnom formatu!';
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Broj telefona'),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Broj telefona je obavezan!';
                      if (!isPhoneNumberValid(value))
                        return 'Broj telefona nije u ispravnom formatu (060-000-000)!';
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Lozinka'),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Lozinka je obavezna!';
                      if (!isPasswordValid(value))
                        return 'Lozinka mora sadržavati minimalno 8 znakova, te velika, mala slova, brojeve i specijalne znakove';
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: confirmedPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Potvrda lozinke'),
                    validator: (value) {
                      if (value != passwordController.text)
                        return 'Lozinke se ne poklapaju!';
                      else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          child: Text(
                            'Spremi',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            var result = await CreateUser();
                            if (result == null) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: const Text(
                                      'Desila se greška prilikom registracije!'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Ok'),
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed('/registrationLogin');
                            }
                          })),
                ],
              ),
            )),
      ),
    );
  }

  Future<dynamic> CreateUser() async {
    var rolesResponse = await APIService.Get('Role', null);
    var roles = rolesResponse!.map((e) => Role.fromJson(e)).toList();
    var clientRoleId  = roles.where((element) => element.name == 'Client').first.id;

    var user = User(
        id: 0,
        username: usernameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
        confirmedPassword: confirmedPasswordController.text,
        roles: [clientRoleId]);

    result = await APIService.Post('User', jsonEncode(user).toString());
    return result;
  }

  bool isEmailValid(String email) {
    RegExp regex = new RegExp(
        r"^(([^<>()[\]\\.,;:\s@']+(\.[^<>()[\]\\.,;:\s@']+)*)|('.+'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
    return regex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    RegExp regex = new RegExp(
        r"^((?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])|(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[^a-zA-Z0-9])|(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[^a-zA-Z0-9])|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^a-zA-Z0-9])).{8,}$");
    return regex.hasMatch(password);
  }

  bool isPhoneNumberValid(String phoneNumber) {
    RegExp regex = new RegExp(r"^[0-9]\d{2}-\d{3}-(\d{4}|\d{3})*$");
    return regex.hasMatch(phoneNumber);
  }
}
