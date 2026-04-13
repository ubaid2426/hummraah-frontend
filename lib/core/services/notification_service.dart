// // lib/services/notification_service.dart
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tzData;

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//   NotificationService._internal();

//   final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     // Initialize timezone
//     tzData.initializeTimeZones();

//     // Android settings
//     const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

//     // iOS settings
//     const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

//     // Initialization settings
//     const InitializationSettings initSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );

//     await _notifications.initialize(initSettings);
//   }

//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'prayer_channel',
//       'Prayer Reminders',
//       channelDescription: 'Notifications for prayer times',
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await _notifications.show(
//       id,
//       title,
//       body,
//       details,
//       payload: payload,
//     );
//   }

//   Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'prayer_channel',
//       'Prayer Reminders',
//       channelDescription: 'Notifications for prayer times',
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await _notifications.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledTime, tz.local),
//       details,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       payload: payload,
//     );
//   }

//   Future<void> cancelNotification(int id) async {
//     await _notifications.cancel(id);
//   }

//   Future<void> cancelAllNotifications() async {
//     await _notifications.cancelAll();
//   }
// }