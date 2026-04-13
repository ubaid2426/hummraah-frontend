// lib/widgets/ziyarah_planner.dart
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';

class ZiyarahPlanner extends StatelessWidget {
  const ZiyarahPlanner({super.key});

  final List<Map<String, dynamic>> locations = const [
    {
      'name': 'makkah',
      'description': 'masjid_al_haram',
      'time': '2h 30m',
      'image': '🕋',
      'color': Color(0xFF2C5F2D),
    },
    {
      'name': 'madinah',
      'description': 'masjid_an_nabawi',
      'time': '4h 15m',
      'image': '🕌',
      'color': Color(0xFFE6B566),
    },
    {
      'name': 'taif',
      'description': 'masjid_abdullah',
      'time': '1h 45m',
      'image': '🏔️',
      'color': Color(0xFFC44536),
    },
    {
      'name': 'badr',
      'description': 'battlefield',
      'time': '3h 00m',
      'image': '⚔️',
      'color': Color(0xFF4A6FA5),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.translate('ziyarah_planner'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C5F2D),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE6B566),
              ),
              child: Text(t.translate('view_all')),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: locations.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final loc = locations[index];
              return Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: loc['color'].withOpacity(0.1)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: loc['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                loc['image'],
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  t.translate(loc['name']),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  t.translate(loc['description']),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: 10,
                                      color: loc['color'],
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      loc['time'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: loc['color'],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: loc['color'].withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add_alert_rounded,
                              color: loc['color'],
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
