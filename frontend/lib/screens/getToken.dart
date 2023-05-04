import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class GetToken extends StatelessWidget {
  const GetToken({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
          onPressed: () {
            print('hi');
          },
          icon: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () async {
            print('hi');
            FirebaseAnalytics analytics = FirebaseAnalytics.instance;
            final fcmToken = await FirebaseMessaging.instance.getToken();
            print(fcmToken);
            // final fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: "BKagOny0KF_2pCJQ3m....moL0ewzQ8rZu");
          },
          child: const Icon(Icons.add),
        )
      ]),
    );
  }
}
