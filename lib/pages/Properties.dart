import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Category.dart';
import 'package:real_estate_mobile/models/City.dart';
import 'package:real_estate_mobile/models/Country.dart';
import 'package:real_estate_mobile/models/OfferType.dart';
import 'package:real_estate_mobile/models/Property.dart';
import 'package:real_estate_mobile/pages/PropertyDetails.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class Properties extends StatefulWidget {
  const Properties({Key? key}) : super(key: key);

  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  TextEditingController _searchTextController = new TextEditingController();

  Country? _selectedCountry = null;
  List<DropdownMenuItem> countries = [];

  City? _selectedCity = null;
  List<DropdownMenuItem> cities = [];

  Category? _selectedCategory = null;
  List<DropdownMenuItem> categories = [];

  OfferType? _selectedOfferType = null;
  List<DropdownMenuItem> offerTypes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nekretnine"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Nekretnine'),
                onTap: () {
                  Navigator.of(context).pushNamed('/properties');
                },
              ),
              ListTile(
                title: Text('Moje nekretnine'),
                onTap: () {
                  Navigator.of(context).pushNamed('/myProperties');
                },
              ),
              ListTile(
                title: Text('Moje posjete'),
                onTap: () {
                  Navigator.of(context).pushNamed('/myVisits');
                },
              ),
              ListTile(
                title: Text('Knjiga žalbi'),
                onTap: () {
                  Navigator.of(context).pushNamed('/complaints');
                },
              ),
              ListTile(
                title: Text('Odjava'),
                onTap: () {
                  APIService.Logout();
                  Navigator.of(context).pushNamed('/registrationLogin');
                },
              )
            ],
          ),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      controller: _searchTextController,
                      decoration: InputDecoration(hintText: 'Naslov'),
                      onChanged: (newVal) => {
                        setState(() {
                          GetProperties();
                        })
                      },
                    ),
                  ),
                  CountryDropDownWidget(),
                  CityDropDownWidget(),
                  CategoryDropDownWidget(),
                  OfferTypeDropDownWidget()
                ],
              ),
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

    if (selectedItem != null && selectedItem.id != 0) {
      _selectedCountry =
          countryList
              .where((element) => element.id == selectedItem.id)
              .first;
    }
    return countryList;
  }

  Widget CountryDropDownWidget() {
    return FutureBuilder<List<Country>>(
        future: GetCountries(_selectedCountry),
        builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
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
        });
  }

  Future<List<City>> GetCities(City? selectedItem) async {
    Map<String, String?> queryParams = {"CountryId": _selectedCountry?.id.toString()};
    List? response = null;
    if(_selectedCountry == null)
       response = await APIService.Get('City', null);
    else
      response = await APIService.Get('City', queryParams);

    var cityList = response!.map((i) => City.fromJson(i)).toList();

    cities = cityList.map((item) {
      return DropdownMenuItem<City>(
        child: Text(item.name),
        value: item,
      );
    }).toList();

    var cityListContainsSelectedItem = cityList.where((element) => element.id == _selectedCity?.id).length > 0;
    if (selectedItem != null && selectedItem.id != 0 && cityListContainsSelectedItem)
      _selectedCity =
          cityList.where((element) => element.id == selectedItem.id).first;
    else
      _selectedCity = null;
    return cityList;
  }

  Widget CityDropDownWidget() {
    return FutureBuilder<List<City>>(
        future: GetCities(_selectedCity),
        builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: DropdownButton<dynamic>(
                hint: Text('Odaberite grad'),
                isExpanded: true,
                items: cities,
                onChanged: (newVal) {
                  setState(() {
                    _selectedCity = newVal as City;
                    GetProperties();
                  });
                },
                value: _selectedCity,
              ),
            );
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
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
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
        });
  }

  Future<List<OfferType>> GetOfferTypes(OfferType? selectedItem) async {
    var response = await APIService.Get('OfferType', null);
    var offerTypeList = response!.map((i) => OfferType.fromJson(i)).toList();

    offerTypes = offerTypeList.map((item) {
      return DropdownMenuItem<OfferType>(
        child: Text(item.name),
        value: item,
      );
    }).toList();

    if (selectedItem != null && selectedItem.id != 0)
      _selectedOfferType =
          offerTypeList.where((element) => element.id == selectedItem.id).first;
    return offerTypeList;
  }

  Widget OfferTypeDropDownWidget() {
    return FutureBuilder<List<OfferType>>(
        future: GetOfferTypes(_selectedOfferType),
        builder:
            (BuildContext context, AsyncSnapshot<List<OfferType>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: DropdownButton<dynamic>(
                hint: Text('Odaberite tip objave'),
                isExpanded: true,
                items: offerTypes,
                onChanged: (newVal) {
                  setState(() {
                    _selectedOfferType = newVal as OfferType;
                    GetProperties();
                  });
                },
                value: _selectedOfferType,
              ),
            );
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

    if (_selectedCategory != null && _selectedCategory?.id != 0)
      queryParams.addAll({'CategoryId': _selectedCategory?.id.toString()});

    if (_selectedOfferType != null && _selectedOfferType?.id != 0)
      queryParams.addAll({'OfferTypeId': _selectedOfferType?.id.toString()});

    if (_selectedCity != null && _selectedCity?.id != 0)
      queryParams.addAll({'CityId': _selectedCity?.id.toString()});

    if (_searchTextController.text.isNotEmpty)
      queryParams.addAll({'SearchText': _searchTextController.text});

    List<String> includeList = ["City", "Category", "OfferType"];

    var properties =
        await APIService.Get('Property', queryParams, includeList: includeList);
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
