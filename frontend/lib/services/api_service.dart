import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
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

  static Future<void> makeCard(int memberId, String baseName, String basePlace,
      String keyword, double latitude, double longitude, File img) async {
    Map<String, dynamic> cardSaveRequestData = {
      "memberId": memberId,
      "baseName": baseName,
      "basePlace": basePlace,
      "keyword": keyword,
      "latitude": latitude,
      "longitude": longitude,
    };

    String cardSaveRequestDtoString = jsonEncode(cardSaveRequestData);

    final url = Uri.parse(
        '$baseUrl/card?cardSaveRequestDtoString=${Uri.encodeComponent(cardSaveRequestDtoString)}');
    final request = http.MultipartRequest('POST', url);

    request.files.add(
      await http.MultipartFile.fromPath(
        'origImageFile',
        img.path,
        filename: basename(img.path),
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();
    if (response.statusCode == 200) {
      print('success');
      final responseData = await response.stream.bytesToString();

      print(responseData);
      // final responseDto = jsonDecode(responseData);
      // print(responseDto);
    } else {
      print('fail');
      print(response.statusCode);
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<String> coordToRegion(Position pos) async {
    final url = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=${pos.longitude}&y=${pos.latitude}');
    const apiKey = '3d2145c1252e1905524178d5b0d99d30';
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'KakaoAK $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['documents'][0]['address_name'];
    } else {
      print(response.statusCode);
      print(response.body);
      return '';
    }
  }
}
