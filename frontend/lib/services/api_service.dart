import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://k8a101.p.ssafy.io:8080/";

  static Future<String> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/member/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      print('hi');
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<String> signup(
      String email, String nickname, String password) async {
    final url = Uri.parse('$baseUrl/member/signup');
    final memberSaveRequestDto = {
      'email': email,
      'nickname': nickname,
      'password': password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(memberSaveRequestDto),
    );
    if (response.statusCode == 200) {
      print('aaa');
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to signup');
    }
  }
}
