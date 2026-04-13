// lib/screens/transport_screen.dart
import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
// import '../../utils/colors.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

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
              title: const Text('Transportation'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.primaryGreen],
                  ),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80'),
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
                  // Quick Book Card
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
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildLocationSelector('Pickup', 'Haram', 'Main Gate'),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFFE6B566),
                                child: Icon(Icons.swap_horiz_rounded, color: Colors.white, size: 16),
                              ),
                            ),
                            Expanded(
                              child: _buildLocationSelector('Dropoff', 'Hotel', 'Hilton Suites'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateTimeSelector('Date', '24 Feb 2026'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDateTimeSelector('Time', '10:30 AM'),
                            ),
                          ],
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
                            child: const Text('Find Transport'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Transport Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Available Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      TextButton(onPressed: () {}, child: const Text('View All')),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildTransportCard(
                    'Private Car',
                    'Toyota Camry',
                    '4 seats · AC',
                    '\$45',
                    'per trip',
                    Icons.directions_car_rounded,
                    AppColors.primaryGreen,
                  ),
                  _buildTransportCard(
                    'Premium Van',
                    'Mercedes Sprinter',
                    '12 seats · Luxury',
                    '\$85',
                    'per trip',
                    Icons.airport_shuttle_rounded,
                    AppColors.primaryGold,
                  ),
                  _buildTransportCard(
                    'Bus Service',
                    'SAPTCO',
                    '40 seats · Scheduled',
                    '\$15',
                    'per person',
                    Icons.directions_bus_rounded,
                    AppColors.primaryTerracotta,
                  ),
                  _buildTransportCard(
                    'Golf Cart',
                    'Haram Service',
                    '4 seats · Within Haram',
                    '\$10',
                    'per ride',
                    Icons.golf_course_rounded,
                    AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelector(String label, String main, String sub) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(main, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text(sub, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelector(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.primaryGold),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransportCard(String title, String subtitle, String specs, String price, String unit, IconData icon, Color color) {
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.people_rounded, size: 12, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(specs, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
              Text(unit, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
}