// lib/widgets/religious_tools.dart
import 'package:flutter/material.dart';
import 'package:hummraah/features/auth/presentation/pages/prayer_times_screen.dart';

import '../../../../core/localization/app_localizations.dart';
import '../pages/Miqaat_Locator_screen.dart';
import '../pages/Prayer/prayer_timing_screen.dart';
import '../pages/dua.dart';
import '../pages/dua_screen.dart';
import '../pages/tawaf_counter_screen.dart';
import '../pages/umrah_guide_screen.dart';

class ReligiousTools extends StatelessWidget {
  const ReligiousTools({super.key});

  final List<Map<String, Object>> tools = const [
    {
      'title': 'prayer_times',
      'subtitle': 'Maghrib: 6:15 PM',
      'icon': Icons.access_time_rounded,
      'color': Color(0xFF2C5F2D),
      'offline': true,
      'screen': PrayerTimingScreen(),
    },
    {
      'title': 'duas',
      'subtitle': 'audio_text',
      'icon': Icons.menu_book_rounded,
      'color': Color(0xFFE6B566),
      'offline': true,
      'screen':  DuaScreenmain(),
    },
    {
      'title': 'umrah_guide',
      'subtitle': 'step_by_step',
      'icon': Icons.mosque_rounded,
      'color': Color(0xFFC44536),
      'offline': true,
      'screen': UmrahGuideScreen(),
    },
    {
      'title': 'tawaf_counter',
      'subtitle': 'track_your_rounds',
      'icon': Icons.rotate_90_degrees_ccw_rounded,
      'color': Color(0xFF4A6FA5),
      'offline': true,
      'screen': TawafCounterScreen(),
    },
    {
      'title': 'miqaat_locator',
      'subtitle': 'find_nearest',
      'icon': Icons.location_on_rounded,
      'color': Color(0xFFB9805E),
      'offline': false,
      'screen': MiqaatLocatorScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.translate('religious_tools'),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C5F2D),
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tools.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),

            itemBuilder: (context, index) {
              final tool = tools[index];

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => tool['screen'] as Widget),
                  );
                },

                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: (tool['color'] as Color).withOpacity(0.1),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (tool['color'] as Color).withOpacity(
                                  0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                tool['icon'] as IconData,
                                color: tool['color'] as Color,
                                size: 20,
                              ),
                            ),
                            const Spacer(),
                            if (tool['offline'] as bool)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.offline_bolt_rounded,
                                  color: Colors.green,
                                  size: 12,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        Text(
                          t.translate(tool['title'] as String),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          t.translate(tool['subtitle'] as String),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
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
