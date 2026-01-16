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

      // Get initial token
      await _getAndStoreToken();

      // Listen for token refresh
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        print('FCM Token refreshed: $newToken');
        _updateTokenInDatabase(newToken);
      });

      FirebaseMessaging.onMessage.listen(_handleNotification);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);
      FirebaseMessaging.onBackgroundMessage(_handleTerminatedNotification);
    } catch (e) {
      print('FCM initialization error: $e');
    }
  }

  static Future<void> _getAndStoreToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print('FCM Token: $token');
        await _updateTokenInDatabase(token);
      }
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }

  static Future<void> _updateTokenInDatabase(String token) async {

    print('Token updated in database: $token');
  }

  static void _handleNotification(RemoteMessage message) {
    print('Notification: ${message.notification?.title}');
  }

  static Future<void> _handleTerminatedNotification(RemoteMessage message) async {
    print('Background notification: ${message.notification?.title}');
  }
}
