// lib/screens/booking_screen.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
import '../../data/models/booking_model.dart';
// import '../utils/colors.dart';
// import '../models/booking_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<String> tabs = ['Upcoming', 'Past', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          labelColor: const Color(0xFF2C5F2D),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFE6B566),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList('upcoming'),
          _buildBookingList('past'),
          _buildBookingList('cancelled'),
        ],
      ),
    );
  }

  Widget _buildBookingList(String type) {
    // Mock data - replace with actual data from provider
    List<BookingModel> bookings = _getMockBookings(type);

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_travel_rounded,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No bookings found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your bookings will appear here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(bookings[index]);
      },
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
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
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getStatusColor(booking.status).withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking.status),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getStatusIcon(booking.status),
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking #${booking.bookingReference ?? booking.id.substring(0, 8)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          booking.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            color: _getStatusColor(booking.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  booking.currency,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        Icons.calendar_today_rounded,
                        'Travel Date',
                        _formatDate(booking.travelDate),
                      ),
                    ),
                    Expanded(
                      child: _buildInfoRow(
                        Icons.people_rounded,
                        'Travelers',
                        '${booking.numberOfTravelers} Person(s)',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        Icons.card_travel_rounded,
                        'Package',
                        booking.packageType,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoRow(
                        Icons.attach_money_rounded,
                        'Total',
                        '${booking.currency} ${booking.totalPrice.toStringAsFixed(0)}',
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (booking.status == 'confirmed')
                      TextButton(
                        onPressed: () {},
                        child: const Text('Download Voucher'),
                      ),
                    const SizedBox(width: 8),
                    if (booking.status == 'confirmed')
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('View Details'),
                      ),
                    if (booking.status == 'pending')
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGold,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Complete Payment'),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[500],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'confirmed':
        return Icons.check_circle_rounded;
      case 'pending':
        return Icons.pending_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonth(date.month)} ${date.year}';
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  List<BookingModel> _getMockBookings(String type) {
    // Mock data - replace with actual data from provider
    return [
      BookingModel(
        id: '1',
        packageId: 'pkg1',
        userId: 'user1',
        bookingDate: DateTime.now(),
        travelDate: DateTime.now().add(const Duration(days: 7)),
        numberOfTravelers: 2,
        packageType: 'Premium Umrah Package',
        totalPrice: 4500,
        currency: 'USD',
        status: type == 'upcoming' ? 'confirmed' : (type == 'past' ? 'completed' : 'cancelled'),
        travelerDetails: {},
        addOns: [],
        bookingReference: 'UMR12345',
        isInsuranceIncluded: true,
      ),
    ];
  }
}