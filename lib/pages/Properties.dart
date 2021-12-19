import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Property.dart';
import 'package:real_estate_mobile/pages/PropertyDetails.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class Properties extends StatefulWidget {
  const Properties({Key? key}) : super(key: key);

  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nekretnine"),
      ),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget(){
    return FutureBuilder<List<Property>>(
      future: GetProperties(),
      builder: (BuildContext context, AsyncSnapshot<List<Property>> snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: Text('Loading...'),);
        }else{
          if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }else{
            return ListView(
              children: snapshot.data!.map((e) => PropertyWidget(e)).toList()
            );
          }
        }
      },
    );
  }

  Future<List<Property>> GetProperties() async {
    var properties = await APIService.Get('Property', null);
    print(properties);
    return properties!.map((e) => Property.fromJson(e)).toList();
  }

  Widget PropertyWidget(property){
    return Card(
        child: TextButton(
          onPressed: () { 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PropertyDetails(property: property))
            );
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(property.id.toString() + " " + property.title + " " + property.price),
          )
        )
    );
  }
}


