// lib/models/notification_model.dart
import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type; // 'prayer', 'permit', 'health', 'travel', 'reminder'
  final String timestamp;
  final bool isRead;
  final IconData icon;
  final Color color;
  final Map<String, dynamic>? data;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timestamp,
    required this.isRead,
    required this.icon,
    required this.color,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      timestamp: json['timestamp'],
      isRead: json['isRead'] ?? false,
      icon: Icons.notifications, // Default icon
      color: const Color(0xFF2C5F2D), // Default color
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'timestamp': timestamp,
      'isRead': isRead,
      'data': data,
    };
  }
}