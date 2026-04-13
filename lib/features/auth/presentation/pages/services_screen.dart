// lib/screens/services_screen.dart
import 'package:flutter/material.dart';
// import '../utils/colors.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'Travel Services',
      'icon': Icons.flight_rounded,
      'count': 8,
      'color': Color(0xFF2C5F2D),
    },
    {
      'title': 'Accommodation',
      'icon': Icons.hotel_rounded,
      'count': 12,
      'color': Color(0xFFE6B566),
    },
    {
      'title': 'Transportation',
      'icon': Icons.directions_bus_rounded,
      'count': 6,
      'color': Color(0xFFC44536),
    },
    {
      'title': 'Food & Dining',
      'icon': Icons.restaurant_rounded,
      'count': 24,
      'color': Color(0xFF4A6FA5),
    },
    {
      'title': 'Shopping',
      'icon': Icons.shopping_bag_rounded,
      'count': 15,
      'color': Color(0xFFB9805E),
    },
    {
      'title': 'Health & Wellness',
      'icon': Icons.health_and_safety_rounded,
      'count': 5,
      'color': Color(0xFF6B4F3C),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: category['color'].withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: category['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  category['icon'],
                                  color: category['color'],
                                  size: 28,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category['title'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${category['count']} services',
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
                      ),
                    ),
                  );
                },
                childCount: categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}