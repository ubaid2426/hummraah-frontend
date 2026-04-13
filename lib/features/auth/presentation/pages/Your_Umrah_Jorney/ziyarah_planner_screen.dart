// lib/features/auth/presentation/screens/ziyarah_planner_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../../../core/utils/colors.dart';

class ZiyarahPlannerScreen extends StatelessWidget {
  const ZiyarahPlannerScreen({super.key});

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
          'Ziyarah Planner',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF2C5F2D),
          ),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Header with Map
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2C5F2D),
                    const Color(0xFF4CAF50),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Icon(
                      Icons.location_on,
                      size: 120,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.explore,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sacred Sites',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Visit the holy places',
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

            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: const Color(0xFF2C5F2D),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFFE6B566),
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Makkah'),
                  Tab(text: 'Madinah'),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  _buildMakkahZiyarah(),
                  _buildMadinahZiyarah(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMakkahZiyarah() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildZiyarahCard(
          name: 'Masjid al-Haram',
          description: 'The holiest mosque in Islam, home to the Kaaba',
          imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa',
          timing: '24/7',
          distance: '0 km',
          highlights: ['Kaaba', 'Hajar al-Aswad', 'Maqam Ibrahim', 'Zamzam Well'],
          isMakkah: true,
        ),
        _buildZiyarahCard(
          name: 'Jabal al-Noor',
          description: 'Mountain containing the Cave of Hira where first revelation came',
          imageUrl: 'https://images.unsplash.com/photo-1566288623392-7367a8e7ace7',
          timing: '6:00 AM - 8:00 PM',
          distance: '4 km',
          highlights: ['Cave of Hira', 'Mountain Climb', 'Panoramic View'],
          isMakkah: true,
        ),
        _buildZiyarahCard(
          name: 'Mina',
          description: 'City of tents where pilgrims stay during Hajj',
          imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa',
          timing: '24/7',
          distance: '8 km',
          highlights: ['Jamarat Bridge', 'Tent City', 'Masjid al-Khayf'],
          isMakkah: true,
        ),
        _buildZiyarahCard(
          name: 'Arafat',
          description: 'Plain where pilgrims gather for the most important day of Hajj',
          imageUrl: 'https://images.unsplash.com/photo-1566288623392-7367a8e7ace7',
          timing: '24/7',
          distance: '22 km',
          highlights: ['Jabal al-Rahmah', 'Masjid al-Namirah'],
          isMakkah: true,
        ),
        _buildZiyarahCard(
          name: 'Muzdalifah',
          description: 'Open area between Mina and Arafat for overnight stay',
          imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa',
          timing: '24/7',
          distance: '15 km',
          highlights: ['Pebble Collection', 'Open Area'],
          isMakkah: true,
        ),
        _buildZiyarahCard(
          name: 'Jabal al-Thawr',
          description: 'Cave where Prophet ﷺ hid during migration',
          imageUrl: 'https://images.unsplash.com/photo-1566288623392-7367a8e7ace7',
          timing: '6:00 AM - 6:00 PM',
          distance: '6 km',
          highlights: ['Cave of Thawr', 'Historical Site'],
          isMakkah: true,
        ),
      ],
    );
  }

  Widget _buildMadinahZiyarah() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildZiyarahCard(
          name: 'Masjid al-Nabawi',
          description: 'The Prophet\'s Mosque with the Green Dome',
          imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa',
          timing: '24/7',
          distance: '0 km',
          highlights: ['Rawdah', 'Green Dome', 'Mihrab', 'Minbar'],
          isMakkah: false,
        ),
        _buildZiyarahCard(
          name: 'Quba Mosque',
          description: 'First mosque built in Islamic history',
          imageUrl: 'https://images.unsplash.com/photo-1566288623392-7367a8e7ace7',
          timing: '24/7',
          distance: '5 km',
          highlights: ['First Mosque', 'Blessed Water Well'],
          isMakkah: false,
        ),
        _buildZiyarahCard(
          name: 'Masjid al-Qiblatain',
          description: 'Mosque where Qibla direction was changed',
          imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa',
          timing: '24/7',
          distance: '4 km',
          highlights: ['Two Qiblas', 'Historical Site'],
          isMakkah: false,
        ),
        _buildZiyarahCard(
          name: 'Mount Uhud',
          description: 'Site of the famous battle',
          imageUrl: 'https://images.unsplash.com/photo-1566288623392-7367a8e7ace7',
          timing: '24/7',
          distance: '6 km',
          highlights: ['Martyrs Cemetery', 'Mountain View'],
          isMakkah: false,
        ),
        _buildZiyarahCard(
          name: 'Jannat al-Baqi',
          description: 'Main cemetery of Madinah',
          imageUrl: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa',
          timing: 'Limited Hours',
          distance: '1 km',
          highlights: ['Companions Graves', 'Prayer Spot'],
          isMakkah: false,
        ),
        _buildZiyarahCard(
          name: 'Masjid al-Fath',
          description: 'Mosque commemorating Battle of Trench',
          imageUrl: 'https://images.unsplash.com/photo-1566288623392-7367a8e7ace7',
          timing: '24/7',
          distance: '7 km',
          highlights: ['Seven Mosques', 'Trench Site'],
          isMakkah: false,
        ),
      ],
    );
  }

  Widget _buildZiyarahCard({
    required String name,
    required String description,
    required String imageUrl,
    required String timing,
    required String distance,
    required List<String> highlights,
    required bool isMakkah,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 160,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(Icons.image, color: Colors.grey[600]),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: isMakkah ? Colors.blue : Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timing,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isMakkah ? Colors.blue : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.locationArrow,
                        size: 14,
                        color: isMakkah ? Colors.blue : Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        distance,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isMakkah ? Colors.blue : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: (isMakkah ? Colors.blue : Colors.green).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isMakkah ? Icons.location_city : Icons.mosque,
                        color: isMakkah ? Colors.blue : Colors.green,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: highlights.map((highlight) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C5F2D).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        highlight,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF2C5F2D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.map, size: 16),
                      label: const Text('Get Directions'),
                      style: TextButton.styleFrom(
                        foregroundColor: isMakkah ? Colors.blue : Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}