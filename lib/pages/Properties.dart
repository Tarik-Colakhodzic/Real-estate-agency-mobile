import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Category.dart';
import 'package:real_estate_mobile/models/Country.dart';
import 'package:real_estate_mobile/models/Property.dart';
import 'package:real_estate_mobile/pages/PropertyDetails.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class Properties extends StatefulWidget {
  const Properties({Key? key}) : super(key: key);

  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  Country? _selectedCountry = null;
  List<DropdownMenuItem> countries = [];

  Category? _selectedCategory = null;
  List<DropdownMenuItem> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nekretnine"),
        ),
        body: Column(
          children: [
            //Center(
              //child: CountryDropDownWidget(),
            //),
            Column(
              children: [
                CountryDropDownWidget(),
                CategoryDropDownWidget()
              ],
            ),
            Expanded(child: bodyWidget())
          ],
        ));
  }

  Future<List<Country>> GetCountries(Country? selectedItem) async {
    var response = await APIService.Get('Country', null);
    var countryList = response!.map((i) => Country.fromJson(i)).toList();

    countries = countryList.map((item) {
      return DropdownMenuItem<Country>(
        child: Text(item.name),
        value: item,
      );
    }).toList();

    if (selectedItem != null && selectedItem.id != 0)
      _selectedCountry =
          countryList.where((element) => element.id == selectedItem.id).first;
    return countryList;
  }

  Widget CountryDropDownWidget() {
    return FutureBuilder<List<Country>>(
        future: GetCountries(_selectedCountry),
        builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: DropdownButton<dynamic>(
                  hint: Text('Odaberite državu'),
                  isExpanded: true,
                  items: countries,
                  onChanged: (newVal) {
                    setState(() {
                      _selectedCountry = newVal as Country;
                      GetProperties();
                    });
                  },
                  value: _selectedCountry,
                ),
              );
            }
          }
        });
  }

  Future<List<Category>> GetCategories(Category? selectedItem) async {
    var response = await APIService.Get('Category', null);
    var categoryList = response!.map((i) => Category.fromJson(i)).toList();

    categories = categoryList.map((item) {
      return DropdownMenuItem<Category>(
        child: Text(item.name),
        value: item,
      );
    }).toList();

    if (selectedItem != null && selectedItem.id != 0)
      _selectedCategory =
          categoryList.where((element) => element.id == selectedItem.id).first;
    return categoryList;
  }

  Widget CategoryDropDownWidget() {
    return FutureBuilder<List<Category>>(
        future: GetCategories(_selectedCategory),
        builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: DropdownButton<dynamic>(
                  hint: Text('Odaberite kategoriju'),
                  isExpanded: true,
                  items: categories,
                  onChanged: (newVal) {
                    setState(() {
                      _selectedCategory = newVal as Category;
                      GetProperties();
                    });
                  },
                  value: _selectedCategory,
                ),
              );
            }
          }
        });
  }

  Widget bodyWidget() {
    return FutureBuilder<List<Property>>(
      future: GetProperties(),
      builder: (BuildContext context, AsyncSnapshot<List<Property>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Loading...'),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return ListView(
                children:
                    snapshot.data!.map((e) => PropertyWidget(e)).toList());
          }
        }
      },
    );
  }

  Future<List<Property>> GetProperties() async {
    Map<String, String?>? queryParams = {'Finished': 'false'};

    if (_selectedCountry != null && _selectedCountry?.id != 0)
      queryParams.addAll({'CountryId': _selectedCountry?.id.toString()});

    if(_selectedCategory != null && _selectedCategory?.id != 0)
      queryParams.addAll({'CategoryId': _selectedCategory?.id.toString()});

    var properties = await APIService.Get('Property', queryParams);
    return properties!.map((e) => Property.fromJson(e)).toList();
  }

  Widget PropertyWidget(property) {
    return Card(
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PropertyDetails(property: property)));
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(property.title + " " + property.price),
            )));
  }
}
