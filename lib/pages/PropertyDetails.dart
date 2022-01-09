import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Property.dart';
import 'package:real_estate_mobile/models/UserProperties.dart';
import 'package:real_estate_mobile/models/Visit.dart';
import 'package:real_estate_mobile/services/APIService.dart';
import 'CarouselWithDots.dart';

class PropertyDetails extends StatefulWidget {
  final Property property;

  PropertyDetails({Key? key, required this.property}) : super(key: key);

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  int? _userPropertyId;
  bool _isVisitRequestSent = false;

  @override
  void initState() {
    super.initState();
    GetMyProperties();
    CheckVisitRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalji'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.property.propertyPhotos.length > 0
                ? CarouselWithDots(
                    imgList: widget.property.propertyPhotos,
                  )
                : Image(
                    image: AssetImage('assets/NoPhoto.png'),
                    height: 350,
                    width: 350,
                  ),
            Text(widget.property.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text("(" + widget.property.price + " KM)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 20),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Kratak opis'),
                    subtitle: Text(widget.property.shortDescription),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Opis'),
                    subtitle: Text(widget.property.description),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Ostale informacije'),
                    subtitle: Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                                child: CardInfoRowWidget("Broj kvadrata",
                                    widget.property.squareMeters.toString())),
                            Expanded(
                                child: CardInfoRowWidget(
                                    "Broj kvadrata balkona",
                                    widget.property.balconySquareMeters
                                        .toString()))
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: CardInfoRowWidget(
                                    "Broj soba",
                                    widget.property.numberOfBedRooms
                                        .toString())),
                            Expanded(
                                child: CardInfoRowWidget(
                                    "Broj kupatila",
                                    widget.property.numberOfBathRooms
                                        .toString()))
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: CardInfoRowWidget(
                                    "Priključak za struju",
                                    widget.property.electricityConnection
                                        .toString(),
                                    isBool: true)),
                            Expanded(
                                child: CardInfoRowWidget("Priključak za vodu",
                                    widget.property.waterConnection.toString(),
                                    isBool: true))
                          ],
                        ),
                        SizedBox(height: 10),
                        CardInfoRowWidget(
                            "Datum objave",
                            widget.property.publishDate.day.toString() +
                                ". " +
                                widget.property.publishDate.month.toString() +
                                ". " +
                                widget.property.publishDate.year.toString() +
                                "."),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Lokacija'),
                    subtitle: Text(widget.property.address +
                        " (" +
                        widget.property.cityName!.toString() +
                        ")"),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Kategorija'),
                    subtitle: Text(widget.property.categoryName!.toString()),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Tip objave'),
                    subtitle: Text(widget.property.offerTypeName!.toString()),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(20)),
              child: _userPropertyId == null
                  ? TextButton(
                      child: Text(
                        'Dodaj u moju listu',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () async {
                        UserProperties userProperties = UserProperties(
                            userId: APIService.loggedUserId,
                            propertyId: widget.property.id);
                        var result = await APIService.Post('UserProperties',
                            jsonEncode(userProperties).toString());
                        await GetMyProperties();
                        if (result != null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: const Text(
                                  'Nekretnina uspješno dodana u listu!'),
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
                    )
                  : TextButton(
                      child: Text(
                        'Ukloni iz liste',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () async {
                        var result = await APIService.Delete(
                            'UserProperties', _userPropertyId.toString());
                        await GetMyProperties();
                        if (result != null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: const Text(
                                  'Nekretnina uspješno uklonjena iz liste!'),
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
            SizedBox(height: 10),
            widget.property.offerTypeName == 'Prodaja'
                ? Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        child: Text(
                          'Kupi',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () async {
                          print("Kupljeno");
                        }),
                  )
                : Text(""),
            _isVisitRequestSent == false
                ? Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        child: Text(
                          'Zakaži posjetu',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () => showVisitScheduler(context)))
                : Text(""),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Future GetMyProperties() async {
    Map<String, String?>? queryParams = {
      'UserId': APIService.loggedUserId.toString(),
      'PropertyId': widget.property.id.toString()
    };

    var myProperties = await APIService.Get('UserProperties', queryParams);
    setState(() {
      if (myProperties!.length > 0)
        _userPropertyId = myProperties.first["id"];
      else
        _userPropertyId = null;
    });
  }

  Future CheckVisitRequest() async {
    Map<String, String?>? queryParams = {
      'ClientId': APIService.loggedUserId.toString(),
      'PropertyId': widget.property.id.toString()
    };

    var isSent = await APIService.Get('Visit', queryParams);
    setState(() {
      if (isSent!.length > 0) _isVisitRequestSent = true;
    });
  }

  Widget CardInfoRowWidget(title, value, {isBool = false}) {
    if (isBool == true) {
      value = value == 'true' ? "Da" : "Ne";
    }
    return Row(
      children: [
        Text(title + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value)
      ],
    );
  }

  Future<void> showVisitScheduler(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          DateTime pickedDate = DateTime.now().add(Duration(days: 1));
          DateTime? date = DateTime.now().add(Duration(days: 1));
          TimeOfDay pickedTime = TimeOfDay(hour: 12, minute: 00);
          TimeOfDay? time = TimeOfDay.now();

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                          "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () async => {
                        date = await showDatePicker(
                            context: context,
                            initialDate: pickedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365))),
                        if (date != null)
                          {
                            setState(() {
                              pickedDate = date!;
                            })
                          }
                      },
                    ),
                    ListTile(
                      title:
                          Text("Time: ${pickedTime.hour}:${pickedTime.minute}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () async => {
                        time = await showTimePicker(
                            context: context, initialTime: pickedTime),
                        if (time != null)
                          {
                            setState(() {
                              pickedTime = time!;
                            })
                          }
                      },
                    )
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () async {
                        var visitDateTime = new DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute);
                        Visit visit = Visit(
                            userId: APIService.loggedUserId,
                            propertyId: widget.property.id,
                            dateTime: visitDateTime.toIso8601String(),
                            approved: false);
                        var result = await APIService.Post(
                            'Visit', jsonEncode(visit).toString());
                        if (result != null) {
                          Navigator.pop(context);
                          CheckVisitRequest();
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: const Text(
                                  'Zahtjev za posjetom uspješno poslan!'),
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
                      child: Text("Spremi"))
                ],
              );
            },
          );
        });
  }
}
