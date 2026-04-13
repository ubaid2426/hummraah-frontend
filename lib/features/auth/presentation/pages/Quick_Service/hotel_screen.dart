// lib/screens/hotels_screen.dart
import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
// import '../../utils/colors.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

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
              title: const Text('Find Your Stay'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.primaryGreen],
                  ),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80'),
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
                  // Search Card
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
                        // Destination
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_rounded, color: Color(0xFF2C5F2D)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Destination', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                                    const Text('Makkah, Saudi Arabia', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.search_rounded, color: Colors.grey),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Check In - Check Out
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateChip('Check In', '24 Feb', 'Wed'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDateChip('Check Out', '25 Mar', 'Thu'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Guests & Rooms
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.people_rounded, color: Color(0xFFE6B566)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Guests & Rooms', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                                    const Text('2 Adults · 1 Room', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.edit_rounded, size: 18, color: Colors.grey),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Search Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Search Hotels', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Filters
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFilterChip('⭐ 5 Star', true),
                        _buildFilterChip('⭐ 4 Star', false),
                        _buildFilterChip('🏨 Near Haram', false),
                        _buildFilterChip('💰 Under \$200', false),
                        _buildFilterChip('🕌 With Mosque View', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Hotel List
                  ...List.generate(4, (index) => _buildHotelCard(index)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String label, String date, String day) {
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
          Text(date, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(day, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.grey[700])),
        selected: isSelected,
        onSelected: (value) {},
        backgroundColor: Colors.white,
        selectedColor: AppColors.primaryGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildHotelCard(int index) {
    List<Map<String, dynamic>> hotels = [
      {'name': 'Hilton Suites Makkah', 'distance': '50m from Haram', 'price': '\$299', 'rating': 4.8, 'image': 'hilton'},
      {'name': 'Fairmont Makkah', 'distance': '100m from Haram', 'price': '\$399', 'rating': 4.9, 'image': 'fairmont'},
      {'name': 'Makkah Clock Tower', 'distance': 'Adjacent to Haram', 'price': '\$459', 'rating': 4.9, 'image': 'clock'},
      {'name': 'Pullman Zamzam', 'distance': '200m from Haram', 'price': '\$249', 'rating': 4.6, 'image': 'pullman'},
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryBlue, AppColors.primaryGreen],
                    ),
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80'),
                      fit: BoxFit.cover,
                      opacity: 0.8,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border_rounded, size: 18, color: Color(0xFFC44536)),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFE6B566), size: 14),
                      const SizedBox(width: 4),
                      Text('${hotels[index]['rating']}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotels[index]['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, size: 12, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(hotels[index]['distance'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(hotels[index]['price'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C5F2D))),
                    Text('/night', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
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