import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/screens/login_entrance.dart';
import 'package:frontend/screens/splash.dart';

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

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  // print('Message data: ${message.data}');
  // print((message.data['FLUTTER_NOTIFICATION_CLICK']));
  if (message.data['FLUTTER_NOTIFICATION_CLICK'] == 'friend') {}
}

void main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Nanum_Square_Neo'),
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
