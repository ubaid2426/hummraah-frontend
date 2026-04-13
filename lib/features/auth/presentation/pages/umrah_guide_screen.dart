// lib/screens/umrah_guide_screen.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
// import '../utils/colors.dart';

class UmrahGuideScreen extends StatelessWidget {
  const UmrahGuideScreen({super.key});

  final List<Map<String, dynamic>> steps = const [
    {
      'step': 1,
      'title': 'Ihram',
      'description': 'Enter the state of spiritual purity',
      'duration': '15 min',
      'icon': Icons.man_rounded,
    },
    {
      'step': 2,
      'title': 'Niyyah',
      'description': 'Intention for Umrah',
      'duration': '2 min',
      'icon': Icons.favorite_rounded,
    },
    {
      'step': 3,
      'title': 'Tawaf',
      'description': 'Seven circuits around Kaaba',
      'duration': '45 min',
      'icon': Icons.rotate_90_degrees_ccw_rounded,
    },
    {
      'step': 4,
      'title': 'Sa\'i',
      'description': 'Walk between Safa and Marwah',
      'duration': '30 min',
      'icon': Icons.directions_walk_rounded,
    },
    {
      'step': 5,
      'title': 'Halq or Taqsir',
      'description': 'Shaving or trimming hair',
      'duration': '10 min',
      'icon': Icons.cut_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Umrah Guide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryGreen,
                          AppColors.primaryBlue,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Progress',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Step 2 of 5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: 0.4,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Steps
                  const Text(
                    'Step by Step Guide',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C5F2D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  ...steps.map((step) => _buildStepCard(step)),
                  
                  const SizedBox(height: 24),
                  
                  // Important Duas
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              color: Color(0xFFE6B566),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Essential Duas',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFF2C5F2D),
                            child: Text('1'),
                          ),
                          title: const Text('Dua for Entering Masjid al-Haram'),
                          trailing: IconButton(
                            icon: const Icon(Icons.volume_up_rounded),
                            onPressed: () {},
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFE6B566),
                            child: Text('2'),
                          ),
                          title: const Text('Dua at Seeing Kaaba'),
                          trailing: IconButton(
                            icon: const Icon(Icons.volume_up_rounded),
                            onPressed: () {},
                          ),
                          onTap: () {},
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

  Widget _buildStepCard(Map<String, dynamic> step) {
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
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryGreen,
                  AppColors.primaryGold,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${step['step']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step['description'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              step['duration'],
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF2C5F2D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}