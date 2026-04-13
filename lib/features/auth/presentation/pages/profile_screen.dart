// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:hummraah/features/auth/presentation/pages/about/about_page.dart';
import 'package:hummraah/features/auth/presentation/pages/faq/faq_page.dart';
import 'package:hummraah/features/auth/presentation/pages/login_page.dart';
import 'package:hummraah/features/auth/presentation/pages/testimonials/testimonials_page.dart';
import '../../../../core/utils/colors.dart';
// import '../utils/colors.dart';
import '../widgets/language_selector.dart';
import 'Login_Page/singup_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('My Profile'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryGreen, AppColors.primaryGold],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Info
                  const CircleAvatar(
                    radius: 50,
                    // backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Abdullah Khan',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ubaid@example.com',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard('Umrah', '3', AppColors.primaryGreen),
                      _buildStatCard('Reviews', '12', AppColors.primaryGold),
                      _buildStatCard(
                        'Points',
                        '450',
                        AppColors.primaryTerracotta,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Menu Items
                  _buildMenuItem(
                    Icons.person_rounded,
                    'Personal Information',
                    () {},
                  ),
                  _buildMenuItem(
                    Icons.card_travel_rounded,
                    'My Bookings',
                    () {},
                  ),
                  _buildMenuItem(Icons.favorite_rounded, 'Wishlist', () {}),
                  _buildMenuItem(
                    Icons.notifications_rounded,
                    'Notifications',
                    () {},
                  ),
                  _buildMenuItem(Icons.language_rounded, 'Language', () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const LanguageSelector(),
                    );
                  }),
                  _buildMenuItem(Icons.login_rounded, 'Login Page', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }),
                  _buildMenuItem(Icons.info_rounded, 'About us', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()),
                    );
                  }),
                  _buildMenuItem(Icons.question_answer, 'FAQ', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQScreen()),
                    );
                  }),
                  _buildMenuItem(Icons.reviews, 'Testimonials', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestimonialsScreen()),
                    );
                  }),
                  _buildMenuItem(Icons.dark_mode_rounded, 'Theme', () {}),
                  _buildMenuItem(Icons.help_rounded, 'Help & Support', () {}),
                  _buildMenuItem(
                    Icons.logout_rounded,
                    'Logout',
                    () {},
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isLogout ? Colors.red : AppColors.primaryGreen).withOpacity(
            0.1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isLogout ? Colors.red : AppColors.primaryGreen,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black87,
          fontWeight: isLogout ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }
}
