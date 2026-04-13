// lib/models/hotel_model.dart
class HotelModel {
  final String id;
  final String name;
  final String nameArabic;
  final String description;
  final String imageUrl;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final double pricePerNight;
  final String currency;
  final String city;
  final double distanceToHaram; // in kilometers
  final List<String> amenities;
  final Map<String, dynamic> roomTypes;
  final String address;
  final double latitude;
  final double longitude;
  final String contactNumber;
  final bool isHalalFriendly;
  final bool hasWheelchairAccess;
  final String? website;

  HotelModel({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.description,
    required this.imageUrl,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.pricePerNight,
    required this.currency,
    required this.city,
    required this.distanceToHaram,
    required this.amenities,
    required this.roomTypes,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.contactNumber,
    required this.isHalalFriendly,
    required this.hasWheelchairAccess,
    this.website,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      nameArabic: json['nameArabic'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      images: List<String>.from(json['images']),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      pricePerNight: json['pricePerNight'].toDouble(),
      currency: json['currency'],
      city: json['city'],
      distanceToHaram: json['distanceToHaram'].toDouble(),
      amenities: List<String>.from(json['amenities']),
      roomTypes: Map<String, dynamic>.from(json['roomTypes']),
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      contactNumber: json['contactNumber'],
      isHalalFriendly: json['isHalalFriendly'] ?? true,
      hasWheelchairAccess: json['hasWheelchairAccess'] ?? false,
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameArabic': nameArabic,
      'description': description,
      'imageUrl': imageUrl,
      'images': images,
      'rating': rating,
      'reviewCount': reviewCount,
      'pricePerNight': pricePerNight,
      'currency': currency,
      'city': city,
      'distanceToHaram': distanceToHaram,
      'amenities': amenities,
      'roomTypes': roomTypes,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'contactNumber': contactNumber,
      'isHalalFriendly': isHalalFriendly,
      'hasWheelchairAccess': hasWheelchairAccess,
      'website': website,
    };
  }
}