class OfferType {
  final int id;
  final String name;

  OfferType({required this.id, required this.name});

  factory OfferType.fromJson(Map<String, dynamic> json) {
    return OfferType(id: int.parse(json["id"].toString()), name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
