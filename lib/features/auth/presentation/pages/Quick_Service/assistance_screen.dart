// lib/screens/assistance_screen.dart
import 'package:flutter/material.dart';
import '../../../../../core/utils/colors.dart';
// import '../../utils/colors.dart';

class AssistanceScreen extends StatelessWidget {
  const AssistanceScreen({super.key});

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
              title: const Text('Special Assistance'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryGold, AppColors.primaryTerracotta],
                  ),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1576091160550-2173dba999ef?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80'),
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
                  // Emergency Contact
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.redAccent],
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
                              child: const Icon(Icons.emergency_rounded, color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Emergency Assistance', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  const Text('24/7 Support', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildEmergencyButton('Call Now', Icons.phone_rounded, Colors.white, Colors.red),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildEmergencyButton('SOS Alert', Icons.warning_rounded, Colors.red, Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Special Assistance Categories
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: [
                      _buildAssistanceCard(
                        'Wheelchair',
                        'Icons.accessible_rounded',
                        'Book wheelchair assistance',
                        AppColors.primaryBlue,
                      ),
                      _buildAssistanceCard(
                        'Elderly Care',
                        'Icons.elderly_rounded',
                        'Special care for seniors',
                        AppColors.primaryGreen,
                      ),
                      _buildAssistanceCard(
                        'Medical Support',
                        'Icons.medical_services_rounded',
                        'First aid & clinics',
                        AppColors.primaryTerracotta,
                      ),
                      _buildAssistanceCard(
                        'Language Help',
                        'Icons.translate_rounded',
                        'Translation services',
                        AppColors.primaryGold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Concierge Services
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
                        const Text('Concierge Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        _buildConciergeItem('Personal Guide', 'Professional guide for your journey', '\$50/day'),
                        _buildConciergeItem('Luggage Assistance', 'Help with luggage at airport/hotel', '\$15'),
                        _buildConciergeItem('Prayer Services', 'Find prayer spaces & times assistance', 'Free'),
                        _buildConciergeItem('Transport Booking', 'Arrange private transport', '\$5 booking'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Request Form
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
                        const Text('Request Special Assistance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Contact Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Describe your requirements',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Submit Request'),
                          ),
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

  Widget _buildEmergencyButton(String text, IconData icon, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: textColor.withOpacity(0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildAssistanceCard(String title, String iconString, String subtitle, Color color) {
    IconData icon;
    switch (iconString) {
      case 'Icons.accessible_rounded':
        icon = Icons.accessible_rounded;
        break;
      case 'Icons.elderly_rounded':
        icon = Icons.elderly_rounded;
        break;
      case 'Icons.medical_services_rounded':
        icon = Icons.medical_services_rounded;
        break;
      case 'Icons.translate_rounded':
        icon = Icons.translate_rounded;
        break;
      default:
        icon = Icons.help_rounded;
    }

    return Container(
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(fontSize: 10, color: Colors.grey[600]), maxLines: 2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConciergeItem(String title, String subtitle, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_rounded, color: Color(0xFF2C5F2D), size: 14),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: price == 'Free' ? Colors.green.withOpacity(0.1) : AppColors.primaryGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              price,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: price == 'Free' ? Colors.green : AppColors.primaryGold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}