// lib/widgets/local_services.dart
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';

class LocalServices extends StatelessWidget {
  const LocalServices({super.key});

  final List<Map<String, dynamic>> services = const [
    {
      'icon': Icons.restaurant_rounded,
      'label': 'food_places',
      'count': '24 nearby',
      'color': Color(0xFF2C5F2D),
    },
    {
      'icon': Icons.shopping_bag_rounded,
      'label': 'souqs',
      'count': '12 nearby',
      'color': Color(0xFFE6B566),
    },
    {
      'icon': Icons.discount_rounded,
      'label': 'discounted_food',
      'count': '8 offers',
      'color': Color(0xFFC44536),
    },
    {
      'icon': Icons.local_parking_rounded,
      'label': 'haram_facilities',
      'count': 'Golf cart',
      'color': Color(0xFF4A6FA5),
    },
  ];

  @override
  Widget build(BuildContext context) {
      final t = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
         t.translate("local_services"),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C5F2D),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: service['color'].withOpacity(0.1),
                ),
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
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: service['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            service['icon'],
                            color: service['color'],
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                            t.translate(service['label']),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                service['count'],
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
      ],
    );
  }
}