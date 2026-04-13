// lib/widgets/journey_timeline.dart
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../pages/Your_Umrah_Jorney/during_stay_services_screen.dart';
import '../pages/Your_Umrah_Jorney/pre_umrah_preparation_screen.dart';
import '../pages/Your_Umrah_Jorney/return_follow_up_screen.dart';
import '../pages/Your_Umrah_Jorney/travel_logistics_screen.dart';
import '../pages/Your_Umrah_Jorney/umrah_ritual_guidance.dart';
import '../pages/Your_Umrah_Jorney/ziyarah_planner_screen.dart';

class JourneyTimeline extends StatelessWidget {
  const JourneyTimeline({super.key});

  final List<Map<String, dynamic>> journeySteps = const [
    {
      'title': 'pre_umrah_preparation',
      'icon': Icons.checklist_rounded,
      'color': Color(0xFF2C5F2D),
      'progress': 0.3,
    },
    {
      'title': 'travel_logistics',
      'icon': Icons.flight_rounded,
      'color': Color(0xFFE6B566),
      'progress': 0.5,
    },
    {
      'title': 'umrah_ritual_guidance',
      'icon': Icons.mosque_rounded,
      'color': Color(0xFFC44536),
      'progress': 0.0,
    },
    {
      'title': 'ziyarah_planner',
      'icon': Icons.map_rounded,
      'color': Color(0xFF4A6FA5),
      'progress': 0.0,
    },
    {
      'title': 'during_stay_services',
      'icon': Icons.room_service_rounded,
      'color': Color(0xFFB9805E),
      'progress': 0.0,
    },
    {
      'title': 'return_follow_up',
      'icon': Icons.home_rounded,
      'color': Color(0xFF6B4F3C),
      'progress': 0.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    void navigateToScreen(BuildContext context, String titleKey) {
      Widget screen;

      switch (titleKey) {
        case 'pre_umrah_preparation':
          screen = const PreUmrahPreparationScreen();
          break;
        case 'travel_logistics':
          screen = const TravelLogisticsScreen();
          break;
        case 'umrah_ritual_guidance':
          screen = const UmrahRitualGuidanceScreen();
          break;
        case 'ziyarah_planner':
          screen = const ZiyarahPlannerScreen();
          break;
        case 'during_stay_services':
          screen = const DuringStayServicesScreen();
          break;
        case 'return_follow_up':
          screen = const ReturnFollowUpScreen();
          break;
        default:
          return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    }

    final t = AppLocalizations.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        navigateToScreen(context, journeySteps[0]['title']);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.translate('your_umrah_journey'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C5F2D),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6B566).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  t.translate('step_1_of_6'),
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE6B566),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: journeySteps.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final step = journeySteps[index];
                return GestureDetector(
                  // ← Changed from InkWell to GestureDetector
                  onTap: () {
                    navigateToScreen(
                      context,
                      step['title'],
                    ); // ← Use current step's title
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: step['color'].withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: step['color'].withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: step['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  step['icon'],
                                  color: step['color'],
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                t.translate(step['title']),

                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (step['progress'] > 0)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: step['color'],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
