// lib/screens/visa_screen.dart
import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
// import '../../utils/colors.dart';

class VisaScreen extends StatelessWidget {
  const VisaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F0),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Visa Services'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryTerracotta, AppColors.primaryGold],
                  ),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1554224154-26032dfc0dbe?ixlib=rb-4.0.3&auto=format&fit=crop&w=1374&q=80'),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Status Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryGreen, AppColors.primaryGreen.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.assignment_turned_in_rounded, color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Visa Status', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  const Text('E-Visa Approved', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text('Valid until 25 Mar 2026', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        LinearProgressIndicator(
                          value: 0.7,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Processing', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
                            Text('70% Complete', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quick Apply Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Quick Visa Application', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        _buildVisaType(
                          'Tourist Visa',
                          'Multiple Entry · 90 Days',
                          '\$180',
                          Icons.flight_rounded,
                          AppColors.primaryGreen,
                        ),
                        _buildVisaType(
                          'Umrah Visa',
                          'Single Entry · 30 Days',
                          '\$150',
                          Icons.mosque_rounded,
                          AppColors.primaryGold,
                        ),
                        _buildVisaType(
                          'Visit Visa',
                          'Single Entry · 90 Days',
                          '\$200',
                          Icons.people_rounded,
                          AppColors.primaryTerracotta,
                        ),
                        _buildVisaType(
                          'Transit Visa',
                          '96 Hours',
                          '\$80',
                          Icons.timer_rounded,
                          AppColors.primaryBlue,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryGreen,
                              side: BorderSide(color: AppColors.primaryGreen.withOpacity(0.3)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('View All Visa Types'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Requirements
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Required Documents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        _buildRequirementItem('Passport with 6+ months validity', true),
                        _buildRequirementItem('Recent passport-size photo', true),
                        _buildRequirementItem('Flight itinerary', true),
                        _buildRequirementItem('Hotel booking confirmation', true),
                        _buildRequirementItem('Travel insurance', false),
                        _buildRequirementItem('Bank statement (last 3 months)', false),
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

  Widget _buildVisaType(String title, String subtitle, String price, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isRequired ? AppColors.primaryGreen.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isRequired ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              size: 16,
              color: isRequired ? AppColors.primaryGreen : Colors.grey,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: isRequired ? Colors.black87 : Colors.grey[600],
              ),
            ),
          ),
          if (isRequired)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Required', style: TextStyle(fontSize: 9, color: Color(0xFF2C5F2D))),
            ),
        ],
      ),
    );
  }
}