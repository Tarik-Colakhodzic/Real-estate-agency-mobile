import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/Agent.dart';
import 'package:real_estate_mobile/models/BookOfComplaints.dart';
import 'package:real_estate_mobile/services/APIService.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  Agent? _selectedAgent = null;
  List<DropdownMenuItem> agents = [];
  TextEditingController commentController = new TextEditingController();
  var result = null;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Knjiga žalbi"),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(60),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AgentDropDownWidget(),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: commentController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Komentar'),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Komentar je obavezan!';
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.blue[700],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                            child: Text(
                              'Spremi',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              var result = await CreateBookOfComplaints();
                              if (result == null) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: const Text(
                                        'Desila se greška prilikom evidentiranja žalbe!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Ok'),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: const Text(
                                        'Žalba uspješno evidentirana!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Ok'),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            })),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<List<Agent>> GetAgents(Agent? selectedItem) async {
    List<String> includeList = ["User"];
    var response = await APIService.Get('Agent', null, includeList: includeList);
    var countryList = response!.map((i) => Agent.fromJson(i)).toList();

    agents = countryList.map((item) {
      return DropdownMenuItem<Agent>(
        child: Text(item.fullName),
        value: item,
      );
    }).toList();

    if (selectedItem != null && selectedItem.id != 0) {
      _selectedAgent =
          countryList
              .where((element) => element.id == selectedItem.id)
              .first;
    }
    return countryList;
  }

  Widget AgentDropDownWidget() {
    return FutureBuilder<List<Agent>>(
        future: GetAgents(_selectedAgent),
        builder: (BuildContext context, AsyncSnapshot<List<Agent>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return DropdownButton<dynamic>(
                hint: Text('Agent'),
                isExpanded: true,
                items: agents,
                onChanged: (newVal) {
                  setState(() {
                    _selectedAgent = newVal as Agent;
                  });
                },
                value: _selectedAgent
            );
        }});
  }

  Future<dynamic> CreateBookOfComplaints() async {
    var complaint = BookOfComplaints(
        id: 0,
        agentId: _selectedAgent?.id,
        comment: commentController.text,
        dateCreated: DateTime.now().toIso8601String());

    result = await APIService.Post(
        'BookOfComplaints', jsonEncode(complaint).toString());
    return result;
  }
}
