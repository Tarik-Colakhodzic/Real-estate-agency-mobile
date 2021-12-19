import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Property.dart';

class PropertyDetails extends StatelessWidget {

  final Property property;
  PropertyDetails({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalji proizvoda'),
      ),
      body: Column(
        children: [
          Text(property.title),
        ],
      ),
    );
  }
}
