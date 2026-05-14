// lib/features/booking/data/models/booking_request_model.dart
class BookingRequestModel {
  final String departureAirportCode;
  final String destinationAirportCode;
  final String startDate;
  final String endDate;
  final int adultsCount;
  final int childrenCount;
  final int infantsCount;
  final String packageType;
  final String hotelDistance;
  final String roomType;
  final bool mealIncluded;
  final bool flightIncluded;
  final String? selectedAirline;
  final String transportType;
  final bool ziyaratIncluded;
  final List<String>? selectedZiyaratPackages;
  final String? specialRequests;

  BookingRequestModel({
    required this.departureAirportCode,
    required this.destinationAirportCode,
    required this.startDate,
    required this.endDate,
    required this.adultsCount,
    required this.childrenCount,
    required this.infantsCount,
    required this.packageType,
    required this.hotelDistance,
    required this.roomType,
    required this.mealIncluded,
    required this.flightIncluded,
    this.selectedAirline,
    required this.transportType,
    required this.ziyaratIncluded,
    this.selectedZiyaratPackages,
    this.specialRequests,
  });

  Map<String, dynamic> toJson() {
    return {
      'departureAirportCode': departureAirportCode,
      'destinationAirportCode': destinationAirportCode,
      'startDate': startDate,
      'endDate': endDate,
      'adultsCount': adultsCount,
      'childrenCount': childrenCount,
      'infantsCount': infantsCount,
      'packageType': packageType,
      'hotelDistance': hotelDistance,
      'roomType': roomType,
      'mealIncluded': mealIncluded,
      'flightIncluded': flightIncluded,
      'selectedAirline': selectedAirline,
      'transportType': transportType,
      'ziyaratIncluded': ziyaratIncluded,
      'selectedZiyaratPackages': selectedZiyaratPackages,
      'specialRequests': specialRequests,
    };
  }
}