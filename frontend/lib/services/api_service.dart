import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://k8a101.p.ssafy.io:8080/";

  static Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/member/login');
    final memberLoginRequestDto = {
      'email': email,
      'password': password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(memberLoginRequestDto),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print('login error');
      return false;
    }
  }

  static Future<bool> signup(
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('nickname', nickname);

      return login(email, password);
    } else {
      print('signup error');
      return false;
    }
  }
}