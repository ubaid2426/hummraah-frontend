// lib/models/location_model.dart
class LocationModel {
  final String id;
  final String name;
  final String nameArabic;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String type; // 'masjid', 'historical', 'market', etc.
  final String city;
  final double rating;
  final int reviewCount;
  final List<String> openingHours;
  final bool isWheelchairAccessible;
  final String? contactNumber;
  final List<String> features;

  LocationModel({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.city,
    required this.rating,
    required this.reviewCount,
    required this.openingHours,
    required this.isWheelchairAccessible,
    this.contactNumber,
    required this.features,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      nameArabic: json['nameArabic'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      type: json['type'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      openingHours: List<String>.from(json['openingHours']),
      isWheelchairAccessible: json['isWheelchairAccessible'],
      contactNumber: json['contactNumber'],
      features: List<String>.from(json['features']),
    );
  }
}