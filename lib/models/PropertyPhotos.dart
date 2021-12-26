import 'package:flutter/material.dart';

class PropertyPhotos {
  final int id;
  final int propertyId;
  final String photo;

  PropertyPhotos(
      {required this.id, required this.propertyId, required this.photo});

  factory PropertyPhotos.fromJson(Map<String, dynamic> json) {
    return PropertyPhotos(
        id: int.parse(json["id"].toString()),
        propertyId: int.parse(json["propertyId"].toString()),
        photo: json["photo"]);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "propertyId": propertyId, "photo": photo};
}
