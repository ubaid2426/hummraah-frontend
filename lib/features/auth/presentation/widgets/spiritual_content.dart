// lib/widgets/spiritual_content.dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';

class SpiritualContent extends StatelessWidget {
  const SpiritualContent({super.key});

  final List<Map<String, dynamic>> content = const [
    {
      'title': 'preparation_guide',
      'duration': '5 min',
      'icon': Icons.play_circle_rounded,
      'color': Color(0xFF2C5F2D),
    },
    {
      'title': 'daily_duas',
      'duration': '3 min',
      'icon': Icons.play_circle_rounded,
      'color': Color(0xFFE6B566),
    },
    {
      'title': 'umrah_rituals',
      'duration': '8 min',
      'icon': Icons.play_circle_rounded,
      'color': Color(0xFFC44536),
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
         t.translate('spiritual_content'),
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
              child:  Text(t.translate('view_all')),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: content.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = content[index];
              return Container(
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: item['color'].withOpacity(0.1),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: item['color'].withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item['icon'],
                              color: item['color'],
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  t.translate(item['title']),
                          
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item['duration'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
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