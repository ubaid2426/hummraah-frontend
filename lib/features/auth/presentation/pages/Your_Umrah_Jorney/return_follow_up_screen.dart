// lib/features/auth/presentation/screens/return_follow_up_screen.dart
import 'package:flutter/material.dart';
// import '../../../../core/utils/colors.dart';

class ReturnFollowUpScreen extends StatelessWidget {
  const ReturnFollowUpScreen({super.key});

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
          'Return & Follow-up',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF2C5F2D),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.brown.shade400,
                    Colors.brown.shade700,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Icon(
                      Icons.home,
                      size: 150,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.assignment_turned_in,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Your Journey Continues',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Post-Umrah guidance and follow-up',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Return Checklist
                  _buildSection(
                    title: 'Return Checklist',
                    icon: Icons.checklist,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        _buildChecklistItem('Confirm flight details', '24 hours before', true),
                        _buildChecklistItem('Pack luggage (max 25kg)', 'Before checkout', true),
                        _buildChecklistItem('Keep important documents handy', 'Passport, tickets', false),
                        _buildChecklistItem('Reach airport 3 hours early', 'International flight', false),
                        _buildChecklistItem('Check visa validity', 'Ensure valid exit', false),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Post-Umrah Actions
                  _buildSection(
                    title: 'Post-Umrah Actions',
                    icon: Icons.auto_awesome,
                    color: Colors.purple,
                    child: Column(
                      children: [
                        _buildActionCard(
                          'Share Your Experience',
                          'Leave a review and help others',
                          Icons.rate_review,
                          Colors.orange,
                        ),
                        _buildActionCard(
                          'Upload Photos',
                          'Preserve your memories',
                          Icons.photo_library,
                          Colors.green,
                        ),
                        _buildActionCard(
                          'Connect with Group',
                          'Stay in touch with fellow pilgrims',
                          Icons.group,
                          Colors.blue,
                        ),
                        _buildActionCard(
                          'Schedule Follow-up',
                          'Share your spiritual journey',
                          Icons.calendar_month,
                          Colors.purple,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Spiritual Follow-up
                  _buildSection(
                    title: 'Spiritual Follow-up',
                    icon: Icons.self_improvement,
                    color: Colors.green,
                    child: Column(
                      children: [
                        _buildSpiritualCard(
                          'Maintain Your Connection',
                          'Continue the habits you built during Umrah',
                          Icons.favorite,
                        ),
                        _buildSpiritualCard(
                          'Daily Dhikr',
                          'Set reminders for morning/evening adhkar',
                          Icons.notification_important,
                        ),
                        _buildSpiritualCard(
                          'Quran Reading Plan',
                          'Continue with a daily reading schedule',
                          Icons.menu_book,
                        ),
                        _buildSpiritualCard(
                          'Weekly Gathering',
                          'Join local Islamic events',
                          Icons.people,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Feedback Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFE6B566).withOpacity(0.2),
                          const Color(0xFF2C5F2D).withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFFE6B566)),
                            SizedBox(width: 8),
                            Text(
                              'How was your experience?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C5F2D),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Your feedback helps us improve our services',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              onPressed: () {},
                              icon: Icon(
                                index < 4 ? Icons.star : Icons.star_border,
                                color: const Color(0xFFE6B566),
                                size: 32,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2C5F2D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Submit Review'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Next Journey
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C5F2D).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.flight_takeoff,
                            color: Color(0xFF2C5F2D),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Plan Your Next Journey',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C5F2D),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Start planning your next Umrah or Hajj',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Color(0xFF2C5F2D),
                          ),
                        ),
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

  // Helper method to build section containers
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C5F2D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // Helper method for checklist items
  Widget _buildChecklistItem(String title, String subtitle, bool isChecked) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isChecked ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isChecked ? Colors.blue : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
                    decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                    color: isChecked ? Colors.grey : Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for action cards
  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
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
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: color,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for spiritual cards
  Widget _buildSpiritualCard(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade50,
            Colors.green.shade100.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green.shade700, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: false,
            onChanged: (value) {},
            activeThumbColor: Colors.green,
          ),
        ],
      ),
    );
  }
}