// lib/screens/planner_screen.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
import '../widgets/journey_timeline.dart';
import '../widgets/ziyarah_planner.dart';
// import '../utils/colors.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journey Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Day selector
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => setState(() => selectedDay = index),
                          child: Container(
                            width: 60,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: selectedDay == index
                                  ? AppColors.primaryGreen
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedDay == index
                                    ? Colors.transparent
                                    : AppColors.primaryGreen.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Day ${index + 1}',
                                  style: TextStyle(
                                    color: selectedDay == index
                                        ? Colors.white
                                        : AppColors.primaryGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '24 Feb',
                                  style: TextStyle(
                                    color: selectedDay == index
                                        ? Colors.white70
                                        : Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Journey Progress
                  const JourneyTimeline(),
                  const SizedBox(height: 24),
                  
                  // Today's Schedule
                  const Text(
                    "Today's Schedule",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C5F2D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Schedule Items
                  _buildScheduleItem(
                    '06:00',
                    'Fajr Prayer at Masjid al-Haram',
                    '📍 Masjid al-Haram',
                    Icons.mosque_rounded,
                    const Color(0xFF2C5F2D),
                  ),
                  _buildScheduleItem(
                    '09:00',
                    'Umrah Rituals - Tawaf',
                    '📍 Kaaba',
                    Icons.rotate_90_degrees_ccw_rounded,
                    const Color(0xFFE6B566),
                  ),
                  _buildScheduleItem(
                    '12:30',
                    'Lunch at Al Baik',
                    '📍 Near Clock Tower',
                    Icons.restaurant_rounded,
                    const Color(0xFFC44536),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Ziyarah Places
                  const ZiyarahPlanner(),
                  const SizedBox(height: 24),
                  
                  // Notes Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personal Notes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Add your notes here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String time, String title, String location, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time.split(':')[0],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  time.split(':')[1],
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 12,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, color: color),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}