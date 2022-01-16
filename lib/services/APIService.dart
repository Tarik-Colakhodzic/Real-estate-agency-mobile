import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class APIService {
  static String username = "";
  static String password = "";
  static String loggedUserFullName = "";
  static int loggedUserId = 0;
  String route = "";

  APIService({this.route = ""});

  void SetParameter(String Username, String Password) {
    username = Username;
    password = Password;
  }

  static Future<List<dynamic>?> Get(String route, dynamic object, {List<String>? includeList = null}) async {
    String queryString = Uri(queryParameters: object).query;
    if(includeList != null && includeList.length > 0){
      includeList.asMap().forEach((index, element) {
        if(index == 0 && object == null){
          queryString = "IncludeList=${element}";
        }
        else {
          queryString += "&IncludeList=${element}";
        }
      });
    }
    String baseUrl = "http://10.0.2.2:5010/api/" + route;
    if (object != null || includeList != null) {
      baseUrl = baseUrl + '?' + queryString;
    }
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {HttpHeaders.authorizationHeader: basicAuth},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    }
    return null;
  }

 static Future<dynamic> Delete(String route, dynamic id) async {
   String baseUrl="http://10.0.2.2:5010/api/"+ route + "/" + id;
   final String basicAuth='Basic '+base64Encode(utf8.encode('$username:$password'));
   final response = await http.delete(
     Uri.parse(baseUrl),
     headers: {HttpHeaders.authorizationHeader: basicAuth},
   );
   if(response.statusCode==200)
     return json.decode(response.body);
   return null;
 }

  static Future<dynamic> Patch(String route, String id, String value) async {
    String baseUrl="http://10.0.2.2:5010/api/" + route + '/' + id + '/' + value;
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = null;
    if(username.isNotEmpty && password.isNotEmpty) {
      response = await http.patch(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Authorization': basicAuth
        },
      );
    }
    if(response.statusCode == 200){
      return "200";
    }
    if(response.statusCode != 200){
      return "500";
    }
    return null;
  }

 static Future<dynamic> Post(String route, String body) async {
   String baseUrl="http://10.0.2.2:5010/api/"+route;
   final String basicAuth =
       'Basic ' + base64Encode(utf8.encode('$username:$password'));
   var response = null;
   if(username.isNotEmpty && password.isNotEmpty) {
     response = await http.post(
       Uri.parse(baseUrl),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': basicAuth
       },
       body: body,
     );
   }
   else{
     response = await http.post(
       Uri.parse(baseUrl),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8'
       },
       body: body,
     );
   }

   if(response.statusCode == 200 && response.body.isEmpty){
     return "200";
   }
   if(response.statusCode != 200 && response.body.isEmpty){
     return "500";
   }
   if (response.statusCode == 200) {
     return json.decode(response.body);
   }
   return null;
 }

 static void Logout(){
    APIService.username = "";
    APIService.password = "";
    APIService.loggedUserId = 0;
    APIService.loggedUserFullName = "";
 }
}
