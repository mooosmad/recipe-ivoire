import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static void initialize() {
    // for ios and web
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      print('A new onMessage event was published!');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  static Future<Future<String?>> getToken() async {
    return FirebaseMessaging.instance.getToken(
        vapidKey:
            "BAbuzBT4bhAQcs0VPrjnTTfvtEjNTGdl_LRfjZzQPNz6c-TWmz02-G6uUEZl3Ukdl4XCuc12SQQ8BOdxgwr0L30");
  }
}
