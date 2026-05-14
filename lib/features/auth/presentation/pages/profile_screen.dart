import 'package:flutter/material.dart';
import 'package:hummraah/features/auth/presentation/pages/Login_Page/login%20_screen.dart';
import 'package:hummraah/features/auth/presentation/pages/Login_Page/singup_screen.dart';
import 'package:hummraah/features/auth/presentation/pages/personal_information.dart';
import 'package:provider/provider.dart';

import 'package:hummraah/features/auth/presentation/pages/about/about_page.dart';
import 'package:hummraah/features/auth/presentation/pages/faq/faq_page.dart';
import 'package:hummraah/features/auth/presentation/pages/testimonials/testimonials_page.dart';
import '../../../../core/utils/colors.dart';
import '../widgets/language_selector.dart';
// import 'Login_Page/singup_screen.dart';
// import 'package:hummraah/features/auth/presentation/pages/edit_profile_screen.dart';

import '../../providers/auth_provider.dart';
import 'package:hummraah/core/utils/ui_feedback.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ================= APP BAR =================
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
              ),
            ),
          ),

          // ================= BODY =================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 👤 PROFILE IMAGE
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),

                  const SizedBox(height: 16),

                  // 👤 NAME
                  Text(
                    user?.name ?? "Guest User",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // ================= STATS =================
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

                  // ================= MENU =================
                  _buildMenuItem(Icons.person, 'Personal Information', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PersonalInformartion(),
                      ),
                    );
                  }),

                  // _buildMenuItem(Icons.edit, 'Edit Profile', () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text("Edit Profile Clicked")),
                  // );

                  // }),
                  _buildMenuItem(Icons.card_travel, 'My Bookings', () {}),

                  _buildMenuItem(Icons.favorite, 'Wishlist', () {}),

                  _buildMenuItem(Icons.notifications, 'Notifications', () {}),

                  _buildMenuItem(Icons.language, 'Language', () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => const LanguageSelector(),
                    );
                  }),

                  _buildMenuItem(Icons.info, 'About Us', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AboutUsScreen()),
                    );
                  }),

                  _buildMenuItem(Icons.question_answer, 'FAQ', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FAQScreen()),
                    );
                  }),
                  _buildMenuItem(Icons.question_answer, 'Login', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  }),

                  _buildMenuItem(Icons.reviews, 'Testimonials', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TestimonialsScreen()),
                    );
                  }),

                  // ================= LOGOUT =================
                  _buildMenuItem(Icons.logout, 'Logout', () {
                    authProvider.logout();

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text("Logged out successfully")),
                    // );
                    UIFeedback.success(context, "Logged out successfully");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  }, isLogout: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= STATS WIDGET =================
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

  // ================= MENU ITEM =================
  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : AppColors.primaryGreen,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }
}
