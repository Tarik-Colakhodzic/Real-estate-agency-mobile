import 'package:flutter/material.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agencija za nekretnine'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Nekretnine'),
              onTap: () {
                Navigator.of(context).pushNamed('/properties');
              },
            ),
            ListTile(
              title: Text('Moje nekretnine'),
              onTap: (){
                Navigator.of(context).pushNamed('/myProperties');
              },
            ),
            ListTile(
              title: Text('Moje posjete'),
              onTap: (){
                Navigator.of(context).pushNamed('/myVisits');
              },
            ),
            ListTile(
              title: Text('Odjava'),
              onTap: (){
                APIService.Logout();
                Navigator.of(context).pushNamed('/registrationLogin');
              },
            )
          ],
        ),
      ),
    );
  }
}
