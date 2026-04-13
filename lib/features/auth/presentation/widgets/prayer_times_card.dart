// lib/widgets/prayer_times_card.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
// import '../utils/colors.dart';

class PrayerTimesCard extends StatelessWidget {
  const PrayerTimesCard({super.key});

  final List<Map<String, dynamic>> prayers = const [
    {'name': 'Fajr', 'time': '5:15 AM', 'icon': Icons.wb_sunny_rounded},
    {'name': 'Sunrise', 'time': '6:30 AM', 'icon': Icons.wb_twilight_rounded},
    {'name': 'Dhuhr', 'time': '12:15 PM', 'icon': Icons.brightness_5_rounded},
    {'name': 'Asr', 'time': '3:45 PM', 'icon': Icons.brightness_4_rounded},
    {'name': 'Maghrib', 'time': '6:15 PM', 'icon': Icons.nights_stay_rounded},
    {'name': 'Isha', 'time': '7:45 PM', 'icon': Icons.nightlight_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Makkah',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '6 Ramadan 1447',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...prayers.map((prayer) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: prayer['name'] == 'Maghrib' 
                        ? AppColors.primaryGold.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    prayer['icon'],
                    color: prayer['name'] == 'Maghrib'
                        ? AppColors.primaryGold
                        : Colors.grey[600],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    prayer['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: prayer['name'] == 'Maghrib' 
                          ? FontWeight.w600 
                          : FontWeight.normal,
                      color: prayer['name'] == 'Maghrib'
                          ? AppColors.primaryGold
                          : Colors.black87,
                    ),
                  ),
                ),
                Text(
                  prayer['time'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: prayer['name'] == 'Maghrib' 
                        ? FontWeight.w600 
                        : FontWeight.normal,
                    color: prayer['name'] == 'Maghrib'
                        ? AppColors.primaryGold
                        : Colors.black87,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}