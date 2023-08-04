import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpDispatch {
  static Map<String, String> headers = {'Content-Type': 'application/json'};

  static Future<dynamic> getHttp(String url, Map<String, dynamic> data) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception("통신 에러 발생!");
    }
  }

  static Future<dynamic> postHttp(String url, Map<String, String> data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }
}
