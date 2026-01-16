import 'package:firebase_messaging/firebase_messaging.dart';

class FCMServices {
  static Future<void> intialize() async {
    try {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen(_handleNotification);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);
      FirebaseMessaging.onBackgroundMessage(_handleTerminatedNotification);
    } catch (e) {
      print('FCM initialization error: $e');
    }
  }

  static void _handleNotification(RemoteMessage message) {
    print('Notification: ${message.notification?.title}');
  }

  static Future<void> _handleTerminatedNotification(RemoteMessage message) async {
    print('Background notification: ${message.notification?.title}');
  }
}

