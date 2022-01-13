import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/User.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  var result = null;

  Future<void> GetData() async {
    result = await APIService.Get('User', null);
    if (result == null) return;
    var users = result.map((e) => User.fromJson((e))).toList();
    if (users.length > 0){
      var user = users
          .where((element) => element.username == usernameController.text)
          .first;
      APIService.loggedUserId = user.id;
      APIService.loggedUserFullName = user.fullName;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(60),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/login.jpg'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Korisničko ime'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Lozinka'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    child: Text(
                      'Prijava',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      APIService.username = usernameController.text;
                      APIService.password = passwordController.text;
                      await GetData();
                      if (result != null) {
                        Navigator.of(context).pushReplacementNamed('/properties');
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Neispravni pristupni podaci!'),
                            content: const Text(
                                'Pogrešno korisničko ime ili lozinka!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Ok'),
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text('Registracija', style: TextStyle(color: Colors.blue)),
                  onTap: () =>
                      Navigator.of(context).pushNamed('/registration'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
