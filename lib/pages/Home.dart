import 'package:flutter/material.dart';

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
        title: Text('Sidemenu'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
/*            DrawerHeader(child: Text('RealEstate'),
            decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),*/
            ListTile(
              title: Text('Nekretnine'),
              onTap: (){
                Navigator.of(context).pushNamed('/properties');
              },
            )
          ],
        ),
      ),
    );
  }
}
