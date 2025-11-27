import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'network_caller.dart';

class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Initialize FCM: Request permissions, get token, send to backend
  static Future<void> initialize() async {
    try {
      // Initialize local notifications
      await _initializeLocalNotifications();

      // Request permission (important for iOS)
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        debugPrint('✅ FCM: Permission granted');

        // Get and save token
        String? token = await getAndSaveToken();
        if (token != null) {
          await sendTokenToBackend(token);
        }

        // Setup token refresh listener
        setupTokenRefresh((newToken) {
          sendTokenToBackend(newToken);
        });
      } else {
        debugPrint('❌ FCM: Permission denied');
      }
    } catch (e) {
      debugPrint('❌ FCM initialization error: $e');
    }
  }

  /// Initialize local notifications and create channel
  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(initSettings);

    // Create notification channel for Android
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // name
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      debugPrint('✅ Android notification channel created');
    }
  }

  /// Get FCM token and save to local storage
  static Future<String?> getAndSaveToken() async {
    try {
      String? token = await _messaging.getToken();
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcmToken', token);
        debugPrint("✅ FCM Token Saved: $token");
      } else {
        debugPrint("❌ FCM Token is null");
      }
      return token;
    } catch (e) {
      debugPrint("❌ FCM Token Error: $e");
      return null;
    }
  }

  /// Listen for token refresh and update
  static void setupTokenRefresh(Function(String) onRefresh) {
    _messaging.onTokenRefresh.listen((newToken) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcmToken', newToken);
      debugPrint("✅ FCM Token Refreshed: $newToken");
      onRefresh(newToken);
    });
  }

  /// Get saved token from local storage
  static Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcmToken');
  }

  /// Send FCM token to backend
  static Future<void> sendTokenToBackend(String token) async {
    try {
      final platform = Platform.isIOS ? 'ios' : 'android';

      final caller = NetworkCaller();
      final response = await caller.post(
        '/user/fcm-token',
        body: {
          'fcmToken': token,
          'platform': platform,
        },
      );

      if (response.isSuccess) {
        debugPrint('✅ FCM token sent to backend successfully');
      } else {
        debugPrint('❌ Failed to send FCM token: ${response.errorMessage}');
      }
    } catch (e) {
      debugPrint('❌ Error sending FCM token to backend: $e');
    }
  }

  /// Handle foreground notification - Display local notification
  static Future<void> handleForegroundMessage(RemoteMessage message) async {
    debugPrint('🔔 === Foreground Notification Received ===');
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');
    debugPrint('Data: ${message.data}');

    // Display notification using local notifications
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      platformDetails,
    );

    debugPrint('✅ Local notification displayed');
  }

  /// Handle notification tap (app opened from notification)
  static void handleMessageTap(RemoteMessage message) {
    debugPrint('👆 === Notification Tapped ===');
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Data: ${message.data}');

    // TODO: Add navigation logic based on notification data
    // Example:
    // if (message.data['type'] == 'chat') {
    //   Get.to(() => ChatPage(id: message.data['chatId']));
    // }
  }

  /// Show a test notification to verify local notifications setup
  static Future<void> showTestNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      0,
      'Test Notification',
      'This is a test notification to verify setup.',
      platformDetails,
    );
  }
}
