import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/screens/login_entrance.dart';
import 'package:frontend/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Mainpage'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

sendAlarm(String title, String content) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await FlutterLocalNotificationsPlugin()
      .show(0, title, content, notificationDetails, payload: 'item x');
}

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  // print('Message data: ${message.data}');
  // print((message.data['FLUTTER_NOTIFICATION_CLICK']));
  if (message.data["body"] == 'REQUEST') {
    sendAlarm('친구 요청이 왔어요!', '친구 요청을 확인해주세요!');
  }
  if (message.data["body"] == 'AUTOMATIC') {
    sendAlarm('자동 일기 생성이 완료되었어요!', '일기장을 확인해주세요!');
  }
  if (message.data["body"] == 'FRIEND') {
    sendAlarm('친구가 일기 교환을 신청했어요!', '교환 여부를 확인해주세요!');
  }
  if (message.data["body"] == 'RANDOM') {
    sendAlarm('랜덤 일기가 도착했어요!', '일기장을 확인해주세요!');
  }
  if (message.data["body"] == 'MANUAL') {}
}

void main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    print('Message data: ${message.data["body"]}');
    print(message.data["body"]);

    if (message.data["body"] == '친구 맺고 일기를 교환해볼까요?') {
      print('친구요청');
      sendAlarm(message.data["title"], message.data["body"]);
    }
    if (message.data["body"] == '오늘의 가짜다이어리를 확인해보세요') {
      print('자동일기');
      sendAlarm(message.data["title"], message.data["body"]);
    }
    if (message.data["body"] == '교환할 일기는 뭐가 좋을까~') {
      print('교환요청');
      sendAlarm(message.data["title"], message.data["body"]);
    }
    if (message.data["body"] == '외계인은 어떤 일기를 보냈을까요?') {
      print('랜덤요청');
      sendAlarm(message.data["title"], message.data["body"]);
    }
    if (message.data["body"] == 'MANUAL') {}

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  FirebaseInAppMessaging.instance.setMessagesSuppressed(false);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await FlutterLocalNotificationsPlugin().initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      // ...
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  final pref = await SharedPreferences.getInstance();
  bool? isLogged = pref.getBool('isLogged');
  isLogged ??= false;
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Nanum_Square_Neo'),
    // home: isLogged ? HomeScreen() : LoginEntrance(),
    home: LoginEntrance(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}
