// lib/features/auth/presentation/screens/during_stay_services_screen.dart
import 'package:flutter/material.dart';
// import '../../../../core/utils/colors.dart';

class DuringStayServicesScreen extends StatelessWidget {
  const DuringStayServicesScreen({super.key});

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
          'During Stay Services',
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
                    Colors.purple.shade400,
                    Colors.purple.shade700,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Icon(
                      Icons.support_agent,
                      size: 150,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.handshake,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Services at Your Fingertips',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Everything you need during your stay',
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
                  // Quick Actions Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isTablet ? 4 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                    children: [
                      _buildServiceCard(
                        'Prayer Times',
                        Icons.access_time,
                        Colors.blue,
                        () {},
                      ),
                      _buildServiceCard(
                        'Qibla Direction',
                        Icons.explore,
                        Colors.green,
                        () {},
                      ),
                      _buildServiceCard(
                        'Duas & Dhikr',
                        Icons.menu_book,
                        Colors.orange,
                        () {},
                      ),
                      _buildServiceCard(
                        'Emergency',
                        Icons.emergency,
                        Colors.red,
                        () {},
                      ),
                      _buildServiceCard(
                        'Translation',
                        Icons.translate,
                        Colors.purple,
                        () {},
                      ),
                      _buildServiceCard(
                        'Nearby Places',
                        Icons.place,
                        Colors.teal,
                        () {},
                      ),
                      _buildServiceCard(
                        'Transport',
                        Icons.directions_bus,
                        Colors.brown,
                        () {},
                      ),
                      _buildServiceCard(
                        'Support',
                        Icons.support_agent,
                        Colors.indigo,
                        () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Hotel Services
                  _buildSection(
                    title: 'Hotel Services',
                    icon: Icons.hotel,
                    color: Colors.purple,
                    child: Column(
                      children: [
                        _buildServiceItem(
                          'Room Service',
                          '24/7 available',
                          Icons.room_service,
                          'Call 100',
                        ),
                        _buildServiceItem(
                          'Laundry',
                          'Same day service',
                          Icons.local_laundry_service,
                          'Ext 1234',
                        ),
                        _buildServiceItem(
                          'Restaurant',
                          'Breakfast 6-10 AM',
                          Icons.restaurant,
                          'Open now',
                        ),
                        _buildServiceItem(
                          'Spa & Gym',
                          'Men only 8 AM - 10 PM',
                          Icons.fitness_center,
                          'Book now',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Transportation
                  _buildSection(
                    title: 'Transportation',
                    icon: Icons.directions_bus,
                    color: Colors.orange,
                    child: Column(
                      children: [
                        _buildShuttleCard(
                          'Hotel to Haram',
                          'Every 30 minutes',
                          'Free',
                          '6:00 AM - 2:00 AM',
                        ),
                        _buildShuttleCard(
                          'Hotel to City Center',
                          'Every hour',
                          '20 SAR',
                          '9:00 AM - 9:00 PM',
                        ),
                        _buildShuttleCard(
                          'Airport Transfer',
                          'On request',
                          '150 SAR',
                          '24/7',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Nearby Services
                  _buildSection(
                    title: 'Nearby Services',
                    icon: Icons.store,
                    color: Colors.green,
                    child: Column(
                      children: [
                        _buildNearbyCard(
                          'Pharmacy',
                          '24/7 Pharmacy',
                          '200m away',
                          Icons.local_pharmacy,
                          'Open 24/7',
                        ),
                        _buildNearbyCard(
                          'Supermarket',
                          'Carrefour',
                          '500m away',
                          Icons.shopping_cart,
                          '8 AM - 12 AM',
                        ),
                        _buildNearbyCard(
                          'ATM',
                          'Al Rajhi Bank',
                          '100m away',
                          Icons.atm,
                          '24/7',
                        ),
                        _buildNearbyCard(
                          'Restaurant',
                          'Al Baik',
                          '300m away',
                          Icons.fastfood,
                          '10 AM - 2 AM',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Important Contacts
                  _buildSection(
                    title: 'Important Contacts',
                    icon: Icons.contact_phone,
                    color: Colors.red,
                    child: Column(
                      children: [
                        _buildContactItem('Hotel Reception', 'Ext. 0', Icons.hotel),
                        _buildContactItem('Tour Guide', '+966 50 123 4567', Icons.person),
                        _buildContactItem('Medical Emergency', '997', Icons.medical_services),
                        _buildContactItem('Police', '999', Icons.local_police),
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

  Widget _buildServiceCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

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
                child: Icon(icon, color: color),
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

  Widget _buildServiceItem(String title, String subtitle, IconData icon, String action) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.purple),
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
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShuttleCard(String route, String frequency, String price, String timing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.directions_bus, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  frequency,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  timing,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C5F2D),
                ),
              ),
              const Text(
                'per person',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyCard(String name, String description, String distance, IconData icon, String timing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  timing,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              distance,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(String name, String number, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.red),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}