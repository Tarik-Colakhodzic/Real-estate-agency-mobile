import 'dart:convert';
import 'dart:typed_data';
import 'package:real_estate_mobile/models/PropertyPhotos.dart';

class Property {
  final int id;
  final String title;
  final String price;
  final List<Uint8List> propertyPhotos;

  Property({
    required this.id,
    required this.title,
    required this.price,
    required this.propertyPhotos
  });

  factory Property.fromJson(Map<String, dynamic> json){
    List<Uint8List> bytes = <Uint8List>[];

    var list = json["propertyPhotos"] as List;
    if (list.length > 0) {
       List<PropertyPhotos> propertyPhotos = list.map((e) => PropertyPhotos.fromJson(e)).toList();
       propertyPhotos.forEach((element) {
         bytes.add(base64.decode(element.photo));
       });
    }

    return Property(
        id: int.parse(json["id"].toString()),
        title: json["title"],
        price: json["price"].toString(),
        propertyPhotos: bytes
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "propertyPhotos": propertyPhotos
  };
}