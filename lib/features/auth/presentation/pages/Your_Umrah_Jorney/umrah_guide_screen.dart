// lib/features/auth/presentation/screens/umrah_guide_screen.dart
import 'package:flutter/material.dart';
// import '../../../../core/utils/colors.dart';
import 'umrah_ritual_guidance.dart';
// import 'umrah_ritual_guidance_screen.dart';
import 'ihram_preparation_screen.dart';
import 'ziyarah_planner_screen.dart';
import 'during_stay_services_screen.dart';
import 'return_follow_up_screen.dart';
import 'travel_logistics_screen.dart';

class UmrahGuideScreen extends StatelessWidget {
  const UmrahGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.black87),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Umrah Guide',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xFF2C5F2D),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?ixlib=rb-4.0.3',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF2C5F2D).withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Complete Umrah Guide',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Everything you need to know for your journey',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              child: Column(
                children: [
                  // Main Guide Cards Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isTablet ? 3 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                    children: [
                      _buildGuideCard(
                        context,
                        title: 'Umrah Rituals',
                        subtitle: 'Step by step guidance',
                        icon: Icons.mosque,
                        color: const Color(0xFF2C5F2D),
                        gradient: const [Color(0xFF2C5F2D), Color(0xFF4CAF50)],
                        screen: const UmrahRitualGuidanceScreen(),
                      ),
                      _buildGuideCard(
                        context,
                        title: 'Ihram Preparation',
                        subtitle: 'How to prepare',
                        icon: Icons.man,
                        color: Colors.blue,
                        gradient: const [Color(0xFF1976D2), Color(0xFF42A5F5)],
                        screen: const IhramPreparationScreen(),
                      ),
                      _buildGuideCard(
                        context,
                        title: 'Ziyarah Planner',
                        subtitle: 'Sacred sites',
                        icon: Icons.location_on,
                        color: Colors.orange,
                        gradient: const [Color(0xFFFF6F00), Color(0xFFFFB300)],
                        screen: const ZiyarahPlannerScreen(),
                      ),
                      _buildGuideCard(
                        context,
                        title: 'During Stay',
                        subtitle: 'Services & tips',
                        icon: Icons.hotel,
                        color: Colors.purple,
                        gradient: const [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
                        screen: const DuringStayServicesScreen(),
                      ),
                      _buildGuideCard(
                        context,
                        title: 'Travel Logistics',
                        subtitle: 'Transport & more',
                        icon: Icons.flight,
                        color: Colors.teal,
                        gradient: const [Color(0xFF00695C), Color(0xFF009688)],
                        screen: const TravelLogisticsScreen(),
                      ),
                      _buildGuideCard(
                        context,
                        title: 'Return Follow-up',
                        subtitle: 'After Umrah',
                        icon: Icons.assignment_turned_in,
                        color: Colors.brown,
                        gradient: const [Color(0xFF5D4037), Color(0xFF8D6E63)],
                        screen: const ReturnFollowUpScreen(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Quick Tips Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFE6B566).withOpacity(0.1),
                          const Color(0xFF2C5F2D).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE6B566).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6B566),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lightbulb,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Quick Tips',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C5F2D),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildTipItem('Start preparations at least 2 months before travel'),
                        _buildTipItem('Learn the duas and rituals beforehand'),
                        _buildTipItem('Pack light but don\'t forget essentials'),
                        _buildTipItem('Stay hydrated and wear comfortable shoes'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required List<Color> gradient,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -20,
              right: -20,
              child: Icon(
                icon,
                size: 100,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 18,
            color: const Color(0xFF2C5F2D),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2C5F2D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}