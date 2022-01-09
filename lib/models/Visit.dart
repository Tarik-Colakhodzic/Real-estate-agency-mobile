class Visit {
  final int? id;
  final int propertyId;
  final int userId;
  final String dateTime;
  final bool approved;

  Visit(
      {this.id,
      required this.propertyId,
      required this.userId,
      required this.dateTime,
      required this.approved});

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
        id: int.parse(json["id"].toString()),
        propertyId: int.parse(json["propertyId"].toString()),
        userId: int.parse(json["userId"].toString()),
        dateTime: json["dateTime"].toString(),
        approved: json["approved"]);
  }

  Map<String, dynamic> toJson() => {
        "propertyId": propertyId,
        "userId": userId,
        "dateTime": dateTime,
        "approved": approved
      };
}
