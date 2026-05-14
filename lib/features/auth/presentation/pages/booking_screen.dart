import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hummraah/features/auth/presentation/bloc/booking_event.dart';
import 'package:hummraah/features/auth/presentation/bloc/booking_state.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/ui_feedback.dart';
import '../../data/models/booking_model.dart';
import '../bloc/booking_bloc.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['Upcoming', 'Past', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    Future.microtask(() {
      if (mounted) {
        context.read<BookingBloc>().add(GetBookingsEvent());
      }
    });
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

      // 🔥 FINAL FIXED WRAPPER
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingLoading) {
            UIFeedback.loading(context);
          }

          if (state is BookingLoaded) {
            UIFeedback.hide(context);
            UIFeedback.success(context, "Bookings Loaded");
          }

          if (state is BookingError) {
            UIFeedback.hide(context);
            UIFeedback.error(context, state.message);
          }
        },

        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            // 🔵 LOADING
            // if (state is BookingLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            // if (state is BookingLoading) {
            //   UIFeedback.loading(context);
            // }

            // 🔴 ERROR
            if (state is BookingError) {
              return Center(child: Text(state.message));
            }

            // 🟢 LOADED
            if (state is BookingLoaded) {
              // EMPTY STATE FIX
              if (state.bookings.isEmpty) {
                return const Center(child: Text("No bookings found"));
              }

              return TabBarView(
                controller: _tabController,
                children: [
                  _buildBookingList(state.bookings, 'upcoming'),
                  _buildBookingList(state.bookings, 'past'),
                  _buildBookingList(state.bookings, 'cancelled'),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  // 🔥 FILTER LOGIC (UNCHANGED BUT CLEAN)
  Widget _buildBookingList(List<BookingModel> allBookings, String type) {
    final bookings = allBookings.where((b) {
      if (type == 'upcoming') return b.status == 'confirmed';
      if (type == 'past') return b.status == 'completed';
      if (type == 'cancelled') return b.status == 'cancelled';
      return false;
    }).toList();

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_travel_rounded, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No bookings found',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Your bookings will appear here',
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getStatusColor(booking.status).withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
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

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        Icons.calendar_today,
                        'Travel Date',
                        _formatDate(booking.travelDate),
                      ),
                    ),
                    Expanded(
                      child: _buildInfoRow(
                        Icons.people,
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
                        Icons.card_travel,
                        'Package',
                        booking.packageType,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoRow(
                        Icons.attach_money,
                        'Total',
                        '${booking.currency} ${booking.totalPrice.toStringAsFixed(0)}',
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
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonth(date.month)} ${date.year}';
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
