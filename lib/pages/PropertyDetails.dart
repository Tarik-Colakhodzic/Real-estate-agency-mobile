import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Property.dart';
import 'package:real_estate_mobile/models/UserProperties.dart';
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

  @override
  void initState() {
    super.initState();
    GetMyProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalji'),
      ),
      body: Column(
        children: [
          widget.property.propertyPhotos.length > 0
              ? CarouselWithDots(
                  imgList: widget.property.propertyPhotos,
                )
              : Image(
                  image: AssetImage('assets/login.jpg'),
                  height: 300,
                  width: 300,
                ),
          Text("title: " + widget.property.title),
          Text("shortDescription: " + widget.property.shortDescription),
          Text("description: " + widget.property.description),
          Text("publishDate: " + widget.property.publishDate),
          Text("balconySquareMeters: " + widget.property.balconySquareMeters),
          Text("numberOfBathRooms: " + widget.property.numberOfBathRooms),
          Text("numberOfBedRooms: " + widget.property.numberOfBedRooms),
          Text("address: " + widget.property.address),
          Text("squareMeters: " + widget.property.squareMeters),
          Text("price: " + widget.property.price),
          Text("internet: " + widget.property.internet.toString()),
          Text("finished: " + widget.property.finished.toString()),
          Text("electricityConnection: " +
              widget.property.electricityConnection.toString()),
          Text(
              "waterConnection: " + widget.property.waterConnection.toString()),
          if (widget.property.cityName != null)
            Text("city: " + widget.property.cityName!.toString()),
          if (widget.property.categoryName != null)
            Text("category: " + widget.property.categoryName!.toString()),
          if (_userPropertyId == null)
            TextButton(
              child: Text(
                'Dodaj u moju listu',
              ),
              onPressed: () async {
                UserProperties userProperties = UserProperties(
                    userId: APIService.loggedUserId,
                    propertyId: widget.property.id);
                var result = await APIService.Post(
                    'UserProperties', jsonEncode(userProperties).toString());
                await GetMyProperties();
                if (result != null) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content:
                          const Text('Nekretnina uspješno dodana u listu!'),
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
          if (_userPropertyId != null)
            TextButton(
              child: Text(
                'Ukloni iz liste',
              ),
              onPressed: () async {
                var result = await APIService.Delete(
                    'UserProperties', _userPropertyId.toString());
                await GetMyProperties();
                if (result != null) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content:
                          const Text('Nekretnina uspješno uklonjena iz liste!'),
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
        ],
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
      if(myProperties!.length > 0)
        _userPropertyId = myProperties.first["id"];
      else
        _userPropertyId = null;
    });
  }
}
