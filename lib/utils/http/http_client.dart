import 'dart:convert';

import 'package:http/http.dart'as http;

class THttpHelper{

  static const String _baseUrl = 'https: //your-api-base-url.com';    // to be replaced by our API base url later

  //helper method to make a GET requet
  static Future<Map<String, dynamic>> get(String  endpoint) async{
 final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
 return _handleResponse(response);
  }

  //helper to make a POST request

  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final response =await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/jason'},
      body: json.encode(data),
    );
  return _handleResponse(response);
  }


   //helper to make a PUT request

  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/jason'},
      body: json.encode(data),
    );
  return _handleResponse(response);
  }

   //helper to make a DELETE request

  static Future<Map<String, dynamic>> delete(String endpoint, dynamic data) async {
    final response =await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
    
  
    );
  return _handleResponse(response);
  }

   //handle http response

  static Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    if(response.statusCode ==200){
      return json.decode(response.body);
    }else{
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }


}