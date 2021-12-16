import 'dart:convert';

class Property {
  final int id;
  final String title;
  final String price;
  //final List<int> photo;

  Property({
    required this.id,
    required this.title,
    required this.price,
    //required this.photo
  });

  factory Property.fromJson(Map<String, dynamic> json){
    //String stringByte = json["photo"] as String;
    //List<int>bytes=base64.decode(stringByte);
    return Property(
        id:int.parse(json["id"].toString()),
        title: json["title"],
        price: json["price"].toString(),
        //photo: bytes
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    //"photo": photo
  };
}