import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Visit.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class MyVisits extends StatefulWidget {
  const MyVisits({Key? key}) : super(key: key);

  @override
  _MyVisitsState createState() => _MyVisitsState();
}

class _MyVisitsState extends State<MyVisits> {
  @override
  void initState() {
    super.initState();
    GetMyVisits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Zakazane posjete"),
        ),
        body: Column(
          children: [Expanded(child: bodyWidget())],
        ));
  }

  Widget bodyWidget() {
    return FutureBuilder<List<Visit>>(
      future: GetMyVisits(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Visit>> snapshot) {
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
                children: snapshot.data!.map((e) => VisitWidget(e)).toList()
            );
          }
        }
      },
    );
  }

  Future<List<Visit>> GetMyVisits() async {
    Map<String, String?>? queryParams = {
      'ClientId': APIService.loggedUserId.toString()
    };
    List<String> includeList = ["Property"];

    var myVisits = await APIService.Get('Visit', queryParams,
        includeList: includeList);
    return myVisits!.map((e) => Visit.fromJson(e)).toList();
  }

  Widget VisitWidget(visit) {
    DateTime visitDateTime = DateTime.parse(visit.dateTime);
    return Card(
        child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Naslov: ${visit.property!.title}"),
                  SizedBox(height: 5,),
                  Text("Vrijeme: ${visitDateTime.month}. ${visitDateTime.day}. ${visitDateTime.year}. ${visitDateTime.hour}:${visitDateTime.minute}"),
                  SizedBox(height: 5,),
                  Text("Odobreno: ${visit.approved ? "Da" : "Ne"}")
                ],
              )
          //Text(visit.property!.title),
            ));
  }
}
