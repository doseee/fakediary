import 'dart:convert';
import 'dart:io';
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('nickname', response.body);
      return true;
    } else {
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
      return login(email, password);
    } else {
      return false;
    }
  }

  static Future<List<String>> getCaption(File img) async {
    const apiKey = "AIzaSyA1Py3uRqxEYNs-EczcNSHrGHAjH1Ej80Q";
    final url = Uri.parse(
        'https://vision.googleapis.com/v1/images:annotate?key=$apiKey');

    print('hi');

    final requestBody = {
      "requests": [
        {
          "image": {
            "content": base64Encode(await img.readAsBytes()),
          },
          "features": [
            {
              "type": "OBJECT_LOCALIZATION",
              "maxResults": 3,
            }
          ],
        },
      ],
    };

    print('hello');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final responses = jsonResponse['responses'];
      final resp = responses[0];

      final objectAnnotations = resp['localizedObjectAnnotations'];
      print(objectAnnotations);
      List<String> objectNames = [];
      for (var objectAnnotation in objectAnnotations) {
        objectNames.add(objectAnnotation['name']);
      }

      print(objectNames);
      return objectNames;
    } else {
      return [];
    }
  }
}
