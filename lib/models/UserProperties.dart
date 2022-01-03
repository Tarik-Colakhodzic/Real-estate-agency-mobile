import 'package:real_estate_mobile/models/Property.dart';

class UserProperties {
  final int? id;
  final int userId;
  final int propertyId;
  final Property? property;

  UserProperties({this.id, required this.userId, required this.propertyId, this.property});

  factory UserProperties.fromJson(Map<String, dynamic> json) {
    return UserProperties(id: int.parse(json["id"].toString()), userId: json["userId"], propertyId: json["propertyId"],
    property: Property.fromJson(json["property"]));
  }

  Map<String, dynamic> toJson() => {"userId": userId, "propertyId": propertyId, "property": property};
}
