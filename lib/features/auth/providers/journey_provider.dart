// lib/providers/journey_provider.dart
import 'package:flutter/material.dart';
import '../data/models/journey_step_model.dart';
// import '../models/journey_step_model.dart';

class JourneyProvider extends ChangeNotifier {
  int _currentStep = 0;
  Map<String, dynamic> _journeyData = {};
  List<JourneyStepModel> _steps = [];

  int get currentStep => _currentStep;
  Map<String, dynamic> get journeyData => _journeyData;
  List<JourneyStepModel> get steps => _steps;

  JourneyProvider() {
    _initializeSteps();
  }

  void _initializeSteps() {
    _steps = [
      JourneyStepModel(
        id: '1',
        title: 'Pre-Umrah Preparation',
        icon: Icons.checklist_rounded,
        color: const Color(0xFF2C5F2D),
        isCompleted: false,
        tasks: [
          'Complete visa application',
          'Book flights',
          'Book hotel',
          'Pack essentials',
          'Get vaccinations',
        ],
      ),
      JourneyStepModel(
        id: '2',
        title: 'Travel & Logistics',
        icon: Icons.flight_rounded,
        color: const Color(0xFFE6B566),
        isCompleted: false,
        tasks: [
          'Check-in online',
          'Arrive at airport',
          'Board flight',
          'Arrival in Saudi',
        ],
      ),
      JourneyStepModel(
        id: '3',
        title: 'Umrah Ritual Guidance',
        icon: Icons.mosque_rounded,
        color: const Color(0xFFC44536),
        isCompleted: false,
        tasks: [
          'Enter Ihram',
          'Make Niyyah',
          'Perform Tawaf',
          'Perform Sa\'i',
          'Halq or Taqsir',
        ],
      ),
    ];
  }

  void setCurrentStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void completeTask(String stepId, String task) {
    final stepIndex = _steps.indexWhere((s) => s.id == stepId);
    if (stepIndex != -1) {
      _steps[stepIndex].completedTasks.add(task);
      notifyListeners();
    }
  }

  void uncompleteTask(String stepId, String task) {
    final stepIndex = _steps.indexWhere((s) => s.id == stepId);
    if (stepIndex != -1) {
      _steps[stepIndex].completedTasks.remove(task);
      notifyListeners();
    }
  }

  void updateJourneyData(String key, dynamic value) {
    _journeyData[key] = value;
    notifyListeners();
  }

  double get overallProgress {
    int totalTasks = 0;
    int completedTasks = 0;
    
    for (var step in _steps) {
      totalTasks += step.tasks.length;
      completedTasks += step.completedTasks.length;
    }
    
    return totalTasks > 0 ? completedTasks / totalTasks : 0;
  }

  void resetJourney() {
    _currentStep = 0;
    _journeyData = {};
    for (var step in _steps) {
      step.completedTasks.clear();
    }
    notifyListeners();
  }
}