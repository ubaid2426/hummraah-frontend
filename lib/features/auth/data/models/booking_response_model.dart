// lib/features/booking/data/models/booking_response_model.dart
class BookingResponseModel {
  final String id;
  final String bookingReference;
  final String status;
  final double totalPrice;
  final String message;
  final DateTime createdAt;

  BookingResponseModel({
    required this.id,
    required this.bookingReference,
    required this.status,
    required this.totalPrice,
    required this.message,
    required this.createdAt,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      id: json['id'] ?? '',
      bookingReference: json['bookingReference'] ?? json['reference'] ?? '',
      status: json['status'] ?? 'pending',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      message: json['message'] ?? 'Booking submitted successfully',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}