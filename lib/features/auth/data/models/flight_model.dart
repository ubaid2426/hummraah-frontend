// lib/models/flight_model.dart
class FlightModel {
  final String id;
  final String airline;
  final String flightNumber;
  final String departureCity;
  final String arrivalCity;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double price;
  final String currency;
  final int stops;
  final String aircraft;
  final String logo;
  final bool isRefundable;
  final List<String> amenities;

  FlightModel({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.currency,
    required this.stops,
    required this.aircraft,
    required this.logo,
    required this.isRefundable,
    required this.amenities,
  });
}