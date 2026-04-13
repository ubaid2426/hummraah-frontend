// lib/screens/flights_screen.dart
import 'package:flutter/material.dart';
import '../../../../../core/utils/colors.dart';
// import '../../utils/colors.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  String selectedTab = 'One Way';
  final List<String> tabs = ['One Way', 'Round Trip', 'Multi City'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F0),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Book Flights',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryGreen,
                      AppColors.primaryGold.withOpacity(0.8),
                    ],
                  ),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-4.0.3&auto=format&fit=crop&w=1374&q=80'),
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
                  // Tab Selector
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: tabs.map((tab) {
                        bool isSelected = tab == selectedTab;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedTab = tab),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  tab,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.grey[600],
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

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
                        // From - To
                        Row(
                          children: [
                            Expanded(
                              child: _buildLocationField(
                                'From',
                                'JED',
                                'Jeddah',
                                Icons.flight_takeoff_rounded,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryGreen.withOpacity(0.1),
                                child: const Icon(
                                  Icons.compare_arrows_rounded,
                                  color: Color(0xFF2C5F2D),
                                  size: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: _buildLocationField(
                                'To',
                                'MED',
                                'Madinah',
                                Icons.flight_land_rounded,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Dates
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateField(
                                'Departure',
                                '24 Feb, 2026',
                                Icons.calendar_today_rounded,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDateField(
                                'Return',
                                '25 Mar, 2026',
                                Icons.calendar_today_rounded,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Passengers & Class
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdownField(
                                'Passengers',
                                '1 Passenger',
                                Icons.people_rounded,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDropdownField(
                                'Class',
                                'Economy',
                                Icons.airline_seat_recline_normal_rounded,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

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
                              elevation: 0,
                            ),
                            child: const Text(
                              'Search Flights',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Popular Routes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Routes',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Route Cards
                  SizedBox(
                    height: 160,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildRouteCard('JED → RUH', 'Saudia Airlines', '2h 15m', '\$180', 'assets/images/riyadh.jpg'),
                        _buildRouteCard('JED → DXB', 'Emirates', '2h 45m', '\$250', 'assets/images/dubai.jpg'),
                        _buildRouteCard('JED → CAI', 'EgyptAir', '1h 55m', '\$150', 'assets/images/cairo.jpg'),
                        _buildRouteCard('JED → IST', 'Turkish Air', '3h 30m', '\$320', 'assets/images/istanbul.jpg'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Featured Airlines
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured Airlines',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Airline Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      List<Map<String, dynamic>> airlines = [
                        {'name': 'Saudia', 'icon': '🇸🇦'},
                        {'name': 'Emirates', 'icon': '🇦🇪'},
                        {'name': 'Qatar', 'icon': '🇶🇦'},
                        {'name': 'Turkish', 'icon': '🇹🇷'},
                        {'name': 'Etihad', 'icon': '🇦🇪'},
                        {'name': 'Kuwait', 'icon': '🇰🇼'},
                        {'name': 'Gulf Air', 'icon': '🇧🇭'},
                        {'name': 'Oman Air', 'icon': '🇴🇲'},
                      ];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              airlines[index]['icon'],
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              airlines[index]['name'],
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField(String label, String code, String city, IconData icon) {
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
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.primaryGreen),
              const SizedBox(width: 4),
              Text(code, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Text(city, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, String date, IconData icon) {
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
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.primaryGold),
              const SizedBox(width: 4),
              Text(date, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, IconData icon) {
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
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.primaryTerracotta),
              const SizedBox(width: 4),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const Spacer(),
              const Icon(Icons.arrow_drop_down_rounded, size: 20, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(String route, String airline, String duration, String price, String image) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1570710891163-6d3b5c47248b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    airline,
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(duration, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C5F2D))),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFFE6B566)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}