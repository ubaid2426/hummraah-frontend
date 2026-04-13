// lib/features/auth/presentation/screens/travel_logistics_screen.dart
import 'package:flutter/material.dart';
// import '../../../../core/utils/colors.dart';

class TravelLogisticsScreen extends StatelessWidget {
  const TravelLogisticsScreen({super.key});

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
          'Travel Logistics',
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
            // Header with Map
            Container(
              height: 180,
              width: double.infinity,
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
                    right: -50,
                    top: -50,
                    child: Icon(
                      Icons.flight,
                      size: 200,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: Icon(
                      Icons.location_on,
                      size: 150,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.map,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Travel Made Easy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your complete travel companion',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
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
                  // Flight Information
                  _buildSection(
                    title: 'Flight Information',
                    icon: Icons.flight,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        _buildLogisticsCard(
                          airline: 'Saudi Airlines',
                          flightNo: 'SV 553',
                          departure: 'Dubai (DXB)',
                          arrival: 'Jeddah (JED)',
                          departureTime: '10:30 AM',
                          arrivalTime: '12:45 PM',
                          date: '15 Mar 2026',
                          duration: '2h 15m',
                        ),
                        _buildLogisticsCard(
                          airline: 'Saudi Airlines',
                          flightNo: 'SV 554',
                          departure: 'Jeddah (JED)',
                          arrival: 'Dubai (DXB)',
                          departureTime: '04:30 PM',
                          arrivalTime: '06:45 PM',
                          date: '25 Mar 2026',
                          duration: '2h 15m',
                          isReturn: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Transportation
                  _buildSection(
                    title: 'Local Transportation',
                    icon: Icons.directions_bus,
                    color: Colors.orange,
                    child: Column(
                      children: [
                        _buildTransportCard(
                          type: 'Airport Transfer',
                          provider: 'Private Car',
                          route: 'Jeddah Airport → Makkah Hotel',
                          time: '1h 30m',
                          price: '150 SAR',
                          icon: Icons.local_airport,
                        ),
                        _buildTransportCard(
                          type: 'Makkah to Madinah',
                          provider: 'VIP Bus',
                          route: 'Makkah → Madinah',
                          time: '4h 30m',
                          price: '80 SAR',
                          icon: Icons.directions_bus,
                        ),
                        _buildTransportCard(
                          type: 'Daily Shuttle',
                          provider: 'Hotel to Haram',
                          route: 'Round trip',
                          time: 'Every 2 hours',
                          price: 'Free',
                          icon: Icons.directions_car,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Hotel Information
                  _buildSection(
                    title: 'Hotel Accommodation',
                    icon: Icons.hotel,
                    color: Colors.purple,
                    child: Column(
                      children: [
                        _buildHotelLogisticsCard(
                          name: 'Pullman Zamzam Makkah',
                          location: '500m from Haram',
                          checkIn: '15 Mar 2026 - 02:00 PM',
                          checkOut: '20 Mar 2026 - 12:00 PM',
                          roomType: 'Deluxe Twin Room',
                          amenities: ['Free WiFi', 'Breakfast', 'Prayer Room'],
                          rating: 4.5,
                        ),
                        const SizedBox(height: 12),
                        _buildHotelLogisticsCard(
                          name: 'Pullman Madinah',
                          location: '300m from Masjid Nabawi',
                          checkIn: '20 Mar 2026 - 03:00 PM',
                          checkOut: '25 Mar 2026 - 12:00 PM',
                          roomType: 'Executive Room',
                          amenities: ['Free WiFi', 'Buffet', 'Spa'],
                          rating: 4.7,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Important Contacts
                  _buildSection(
                    title: 'Emergency Contacts',
                    icon: Icons.contact_emergency,
                    color: Colors.red,
                    child: Column(
                      children: [
                        _buildContactCard(
                          name: 'Tour Guide - Ahmed',
                          role: '24/7 Support',
                          phone: '+966 50 123 4567',
                          icon: Icons.support_agent,
                        ),
                        _buildContactCard(
                          name: 'Embassy',
                          role: 'Your Country Embassy',
                          phone: '+966 11 123 4567',
                          icon: Icons.account_balance,
                        ),
                        _buildContactCard(
                          name: 'Emergency',
                          role: 'Police/Ambulance',
                          phone: '997',
                          icon: Icons.emergency,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Weather Information
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade400,
                          Colors.blue.shade600,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.wb_sunny, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Weather Forecast',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildWeatherDay('Day 1', '🌤️', '28°C'),
                            _buildWeatherDay('Day 2', '☀️', '30°C'),
                            _buildWeatherDay('Day 3', '🌤️', '29°C'),
                            _buildWeatherDay('Day 4', '☀️', '31°C'),
                            _buildWeatherDay('Day 5', '🌥️', '27°C'),
                          ],
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

  Widget _buildLogisticsCard({
    required String airline,
    required String flightNo,
    required String departure,
    required String arrival,
    required String departureTime,
    required String arrivalTime,
    required String date,
    required String duration,
    bool isReturn = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isReturn ? Colors.orange.withOpacity(0.3) : Colors.grey[200]!,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isReturn ? Colors.orange.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isReturn ? Icons.flight_land : Icons.flight_takeoff,
                      color: isReturn ? Colors.orange : Colors.blue,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isReturn ? 'Return Flight' : 'Departure Flight',
                    style: TextStyle(
                      fontSize: 12,
                      color: isReturn ? Colors.orange : Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C5F2D).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  flightNo,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C5F2D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      departureTime,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      departure,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.flight, color: Colors.grey[400], size: 20),
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C5F2D),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      arrivalTime,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      arrival,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransportCard({
    required String type,
    required String provider,
    required String route,
    required String time,
    required String price,
    required IconData icon,
  }) {
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      type,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C5F2D).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        provider,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF2C5F2D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  route,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.timer, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C5F2D),
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

  Widget _buildHotelLogisticsCard({
    required String name,
    required String location,
    required String checkIn,
    required String checkOut,
    required String roomType,
    required List<String> amenities,
    required double rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6B566).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFE6B566), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on, size: 12, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                location,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(Icons.login, 'Check-in', checkIn),
              ),
              Expanded(
                child: _buildInfoRow(Icons.logout, 'Check-out', checkOut),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2C5F2D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              roomType,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C5F2D),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            children: amenities.map((amenity) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  amenity,
                  style: const TextStyle(fontSize: 9),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey[500],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required String name,
    required String role,
    required String phone,
    required IconData icon,
  }) {
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
            child: Icon(icon, color: Colors.red, size: 20),
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
                  role,
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
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              phone,
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

  Widget _buildWeatherDay(String day, String icon, String temp) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          icon,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          temp,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}