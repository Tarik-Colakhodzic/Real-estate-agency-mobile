import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/UserProperties.dart';
import 'package:real_estate_mobile/pages/PropertyDetails.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class MyProperties extends StatefulWidget {
  const MyProperties({Key? key}) : super(key: key);

  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  @override
  void initState() {
    super.initState();
    GetMyProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Moje nekretnine"),
        ),
        body: Column(
          children: [Expanded(child: bodyWidget())],
        ));
  }

  Widget bodyWidget() {
    return FutureBuilder<List<UserProperties>>(
      future: GetMyProperties(),
      builder:
          (BuildContext context, AsyncSnapshot<List<UserProperties>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Loading...'),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return ListView(
                children: snapshot.data!
                    .map((e) => PropertyWidget(e.property, e.id))
                    .toList());
          }
        }
      },
    );
  }

  Future<List<UserProperties>> GetMyProperties() async {
    Map<String, String?>? queryParams = {
      'UserId': APIService.loggedUserId.toString()
    };
    List<String> includeList = ["Property", "Property.City", "Property.Category", "Property.OfferType"];

    var myProperties = await APIService.Get('UserProperties', queryParams,
        includeList: includeList);
    return myProperties!.map((e) => UserProperties.fromJson(e)).toList();
  }

  Widget PropertyWidget(property, userPropertyId) {
    return Card(
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PropertyDetails(property: property))).then((_) => { setState(() {

                          })});
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(property.title + " " + property.price),
            )));
  }
}
