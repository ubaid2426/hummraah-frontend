// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';

import '../../data/models/notification_model.dart';
// import '../utils/colors.dart';
// import '../models/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<NotificationModel> notifications = const [
    NotificationModel(
      id: '1',
      title: 'Prayer Time Reminder',
      body: 'Maghrib prayer is in 15 minutes',
      type: 'prayer',
      timestamp: '5 min ago',
      isRead: false,
      icon: Icons.access_time_rounded,
      color: Color(0xFF2C5F2D),
    ),
    NotificationModel(
      id: '2',
      title: 'Umrah Permit Approved',
      body: 'Your Umrah permit for tomorrow has been approved',
      type: 'permit',
      timestamp: '2 hours ago',
      isRead: false,
      icon: Icons.assignment_turned_in_rounded,
      color: Color(0xFFE6B566),
    ),
    NotificationModel(
      id: '3',
      title: 'Health Advisory',
      body: 'Stay hydrated during Tawaf. Temperature: 38°C',
      type: 'health',
      timestamp: '5 hours ago',
      isRead: true,
      icon: Icons.health_and_safety_rounded,
      color: Color(0xFFC44536),
    ),
    NotificationModel(
      id: '4',
      title: 'Flight Update',
      body: 'Your flight SV-553 is on time',
      type: 'travel',
      timestamp: '1 day ago',
      isRead: true,
      icon: Icons.flight_rounded,
      color: Color(0xFF4A6FA5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationCard(notification);
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.white : notification.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead 
              ? Colors.grey.withOpacity(0.2)
              : notification.color.withOpacity(0.3),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: notification.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification.icon,
            color: notification.color,
            size: 24,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.body,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              notification.timestamp,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        trailing: notification.isRead 
            ? null 
            : Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF2C5F2D),
                  shape: BoxShape.circle,
                ),
              ),
        onTap: () {},
      ),
    );
  }
}