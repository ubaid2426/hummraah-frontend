// lib/models/booking_model.dart
class BookingModel {
  final String id;
  final String packageId;
  final String userId;
  final DateTime bookingDate;
  final DateTime travelDate;
  final int numberOfTravelers;
  final String packageType;
  final double totalPrice;
  final String currency;
  final String status; // 'pending', 'confirmed', 'cancelled', 'completed'
  final Map<String, dynamic> travelerDetails;
  final List<String> addOns;
  final String? paymentMethod;
  final String? bookingReference;
  final bool isInsuranceIncluded;

  BookingModel({
    required this.id,
    required this.packageId,
    required this.userId,
    required this.bookingDate,
    required this.travelDate,
    required this.numberOfTravelers,
    required this.packageType,
    required this.totalPrice,
    required this.currency,
    required this.status,
    required this.travelerDetails,
    required this.addOns,
    this.paymentMethod,
    this.bookingReference,
    required this.isInsuranceIncluded,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      packageId: json['packageId'],
      userId: json['userId'],
      bookingDate: DateTime.parse(json['bookingDate']),
      travelDate: DateTime.parse(json['travelDate']),
      numberOfTravelers: json['numberOfTravelers'],
      packageType: json['packageType'],
      totalPrice: json['totalPrice'].toDouble(),
      currency: json['currency'],
      status: json['status'],
      travelerDetails: Map<String, dynamic>.from(json['travelerDetails']),
      addOns: List<String>.from(json['addOns']),
      paymentMethod: json['paymentMethod'],
      bookingReference: json['bookingReference'],
      isInsuranceIncluded: json['isInsuranceIncluded'] ?? false,
    );
  }
}