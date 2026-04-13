// lib/widgets/smart_features.dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';

class SmartFeatures extends StatelessWidget {
  const SmartFeatures({super.key});

  final List<Map<String, dynamic>> features = const [
    {
      'icon': Icons.notifications_active_rounded,
      'label': 'prayer_reminders',
      'color': Color(0xFF2C5F2D),
    },
    {
      'icon': Icons.assignment_rounded,
      'label': 'permit_reminders',
      'color': Color(0xFFE6B566),
    },
    {
      'icon': Icons.health_and_safety_rounded,
      'label': 'health_vaccination',
      'color': Color(0xFFC44536),
    },
    {
      'icon': Icons.emergency_rounded,
      'label': 'emergency_contact',
      'color': Color(0xFF4A6FA5),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(
      children: features.map((feature) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: feature['color'].withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: feature['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      feature['icon'],
                      color: feature['color'],
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  AutoSizeText(
                    t.translate(feature['label']),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
