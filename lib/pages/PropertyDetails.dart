import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Property.dart';
import 'CarouselWithDots.dart';

class PropertyDetails extends StatelessWidget {
  final Property property;

  PropertyDetails({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalji'),
      ),
      body: Column(
        children: [
          property.propertyPhotos.length > 0
              ? CarouselWithDots(
                  imgList: property.propertyPhotos,
                )
              : Image(
                  image: AssetImage('assets/login.jpg'),
                  height: 300,
                  width: 300,
                ),
          Text("title: " + property.title),
          Text("shortDescription: " + property.shortDescription),
          Text("description: " + property.description),
          Text("publishDate: " + property.publishDate),
          Text("balconySquareMeters: " + property.balconySquareMeters),
          Text("numberOfBathRooms: " + property.numberOfBathRooms),
          Text("numberOfBedRooms: " + property.numberOfBedRooms),
          Text("address: " + property.address),
          Text("squareMeters: " + property.squareMeters),
          Text("price: " + property.price),
          Text("internet: " + property.internet.toString()),
          Text("finished: " + property.finished.toString()),
          Text("electricityConnection: " +
              property.electricityConnection.toString()),
          Text("waterConnection: " + property.waterConnection.toString()),
          if(property.cityName != null)
            Text("city: " + property.cityName!.toString()),
          if(property.categoryName != null)
            Text("category: " + property.categoryName!.toString()),
        ],
      ),
    );
  }
}
