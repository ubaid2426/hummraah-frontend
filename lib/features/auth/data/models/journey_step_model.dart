// lib/models/journey_step_model.dart
import 'package:flutter/material.dart';

class JourneyStepModel {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  bool isCompleted;
  final List<String> tasks;
  List<String> completedTasks;

  JourneyStepModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    this.isCompleted = false,
    required this.tasks,
    List<String>? completedTasks,
  }) : completedTasks = completedTasks ?? [];

  double get progress {
    if (tasks.isEmpty) return 0;
    return completedTasks.length / tasks.length;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'tasks': tasks,
      'completedTasks': completedTasks,
    };
  }

  factory JourneyStepModel.fromJson(Map<String, dynamic> json) {
    return JourneyStepModel(
      id: json['id'],
      title: json['title'],
      icon: Icons.circle, // Note: IconData can't be serialized easily
      color: const Color(0xFF2C5F2D), // Default color
      isCompleted: json['isCompleted'] ?? false,
      tasks: List<String>.from(json['tasks'] ?? []),
      completedTasks: List<String>.from(json['completedTasks'] ?? []),
    );
  }
}