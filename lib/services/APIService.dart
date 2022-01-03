import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class APIService {
  static String username = "";
  static String password = "";
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
      includeList.forEach((element) {
        queryString += "&IncludeList=${element}";
      });
    }
    String baseUrl = "http://127.0.0.1:5010/api/" + route;
    if (object != null) {
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

// static Future<dynamic> GetById(String route, dynamic id) async{
//   String baseUrl="http://127.0.0.1:5010/api/"+ route + "/" + id;
//   final String basicAuth='Basic '+base64Encode(utf8.encode('$username:$password'));
//   final response= await http.get(
//     Uri.parse(baseUrl),
//     headers: {HttpHeaders.authorizationHeader:basicAuth},
//   );
//   if(response.statusCode==200)
//     return json.decode(response.body);
//   return null;
// }

 static Future<dynamic> Delete(String route, dynamic id) async {
   String baseUrl="http://127.0.0.1:5010/api/"+ route + "/" + id;
   final String basicAuth='Basic '+base64Encode(utf8.encode('$username:$password'));
   final response = await http.delete(
     Uri.parse(baseUrl),
     headers: {HttpHeaders.authorizationHeader: basicAuth},
   );
   if(response.statusCode==200)
     return json.decode(response.body);
   return null;
 }

 static Future<dynamic> Post(String route, String body) async {
   String baseUrl="http://127.0.0.1:5010/api/"+route;
   final String basicAuth =
       'Basic ' + base64Encode(utf8.encode('$username:$password'));
   final response = await http.post(
     Uri.parse(baseUrl),
     headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
       'Authorization': basicAuth
     },
     body: body,
   );

   if (response.statusCode == 200) {
     return json.decode(response.body);
   }
   return null;
 }
}
