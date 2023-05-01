import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8080/";

  static Future<bool> login(String email, String password) async {
    print('loginstart');
    final url = Uri.parse('$baseUrl/member/login');
    final memberLoginRequestDto = {
      'email': email,
      'password': password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(memberLoginRequestDto),
    );
    print('loginmiddle');
    if (response.statusCode == 200) {
      print('success');
      final prefs = await SharedPreferences.getInstance();
      final respJson = jsonDecode(utf8.decode(response.bodyBytes));
      print(respJson);
      final parsedTime =
          respJson['autoDiaryTime']?.split(':') ?? ["00", "00", "00"];
      final hour = int.parse(parsedTime[0] ?? '00');
      final minute = int.parse(parsedTime[1] ?? '00');
      final second = int.parse(parsedTime[2] ?? '00');
      await prefs.setInt('hour', hour);
      await prefs.setInt('minute', minute);
      await prefs.setInt('second', second);
      await prefs.setInt('memberId', respJson['memberId']);
      await prefs.setString('nickname', respJson['nickname']);
      await prefs.setString('diaryBaseName', respJson['diaryBaseName'] ?? '');
      print('end');
      return true;
    } else {
      print('failed');
      print(response.body);
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
      print('success');
      return login(email, password);
    } else {
      print('failed');
      print(response.body);
      return false;
    }
  }

  static Future<String> getTranslation_papago(String content) async {
    String clientId = "iaAJOaHEssiAn4KWNlV4";
    String clientSecret = "UR4EhjWIjn";
    String contentType = "application/x-www-form-urlencoded; charset=UTF-8";
    String url = "https://openapi.naver.com/v1/papago/n2mt";

    http.Response trans = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': contentType,
        'X-Naver-Client-Id': clientId,
        'X-Naver-Client-Secret': clientSecret
      },
      body: {
        'source': "en",
        'target': "ko",
        'text': content,
      },
    );
    if (trans.statusCode == 200) {
      var dataJson = jsonDecode(trans.body);
      print(dataJson);
      var resultPapago = dataJson['message']['result']['translatedText'];
      return resultPapago;
    } else {
      print(trans.statusCode);
      return content;
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
        final ko = await getTranslation_papago(objectAnnotation['name']);
        objectNames.add(ko);
      }

      print(objectNames);
      return objectNames;
    } else {
      return [];
    }
  }

  static Future<Map<String, dynamic>> makeCard(
      int memberId,
      String baseName,
      String basePlace,
      String keyword,
      double latitude,
      double longitude,
      File img) async {
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
    // if (response.statusCode == 200) {
    print('success');
    final responseData = await response.stream.bytesToString();

    // print(responseData);
    final responseDto = jsonDecode(responseData);
    // print(responseDto['memberId']);
    Map<String, dynamic> card = responseDto;

    return card;
    // } else {
    //   print('fail');
    //   print(response.statusCode);
    // }
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

  static Future<void> modifyUser(String newNickname, String hour, String minute,
      String second, String newDiaryBaseName) async {
    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('memberId');
    final url = Uri.parse('$baseUrl/member/$memberId');
    final autoDiaryTime = '$hour:$minute:$second';
    print(autoDiaryTime);
    print(newDiaryBaseName);
    final memberUpdateRequestDto = {
      "autoDiaryTime": autoDiaryTime,
      "diaryBaseName": newDiaryBaseName,
      "nickname": newNickname,
    };
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(memberUpdateRequestDto),
    );
    if (response.statusCode == 200) {
      print('success');
      prefs.setString('nickname', newNickname);
      prefs.setString('diaryBaseName', newDiaryBaseName);

      final parsedTime = autoDiaryTime.split(':');
      final hour = int.parse(parsedTime[0]);
      final minute = int.parse(parsedTime[1]);
      final second = int.parse(parsedTime[2]);
      prefs.setInt('hour', hour);
      prefs.setInt('minute', minute);
      prefs.setInt('second', second);

      print(response.body);
    } else {
      print('fail');
      print(response.statusCode);
      print(response.body);
    }
  }
}
