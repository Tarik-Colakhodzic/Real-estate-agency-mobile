import 'dart:convert';
import 'dart:typed_data';
import 'package:real_estate_mobile/models/PropertyPhotos.dart';

class Property {
  final int id;
  final String title;
  final String price;
  final String shortDescription;
  final String description;
  final String publishDate;
  final String squareMeters;
  final String address;
  final bool waterConnection;
  final bool electricityConnection;
  final bool finished;
  final String numberOfBedRooms;
  final String numberOfBathRooms;
  final String balconySquareMeters;
  final bool internet;
  final String? cityName;
  final String? categoryName;
  final List<Uint8List> propertyPhotos;

  Property({
    required this.id,
    required this.title,
    required this.price,
    required this.shortDescription,
    required this.description,
    required this.publishDate,
    required this.squareMeters,
    required this.address,
    required this.waterConnection,
    required this.electricityConnection,
    required this.finished,
    required this.numberOfBedRooms,
    required this.numberOfBathRooms,
    required this.balconySquareMeters,
    required this.internet,
    required this.propertyPhotos,
    this.cityName,
    this.categoryName
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    List<Uint8List> bytes = <Uint8List>[];

    var list = json["propertyPhotos"] as List;
    if (list.length > 0) {
      List<PropertyPhotos> propertyPhotos =
          list.map((e) => PropertyPhotos.fromJson(e)).toList();
      propertyPhotos.forEach((element) {
        bytes.add(base64.decode(element.photo));
      });
    }

    return Property(
        id: int.parse(json["id"].toString()),
        title: json["title"],
        price: json["price"].toString(),
        shortDescription: json["shortDescription"],
        description: json["description"],
        publishDate: json["publishDate"],
        squareMeters: json["squareMeters"].toString(),
        address: json["address"],
        waterConnection: json["waterConnection"],
        electricityConnection: json["electricityConnection"],
        finished: json["finished"],
        numberOfBedRooms: json["numberOfBedRooms"].toString(),
        numberOfBathRooms: json["numberOfBathRooms"].toString(),
        balconySquareMeters: json["balconySquareMeters"].toString(),
        internet: json["internet"],
        cityName: json["cityName"],
        categoryName: json["categoryName"],
        propertyPhotos: bytes);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "shortDescription": shortDescription,
        "description": description,
        "publishDate": publishDate,
        "squareMeters": squareMeters,
        "address": address,
        "waterConnection": waterConnection,
        "electricityConnection": electricityConnection,
        "finished": finished,
        "numberOfBedRooms": numberOfBedRooms,
        "numberOfBathRooms": numberOfBathRooms,
        "balconySquareMeters": balconySquareMeters,
        "internet": internet,
        "propertyPhotos": propertyPhotos
      };
}
