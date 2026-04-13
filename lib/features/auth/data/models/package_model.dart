// lib/models/package_model.dart
class PackageModel {
  final String id;
  final String title;
  final String type;
  final double price;
  final String currency;
  final int duration;
  final List<String> inclusions;
  final List<String> exclusions;
  final String imageUrl;
  final double rating;
  final bool isPopular;
  final bool isRecommended;
  
  PackageModel({
    required this.id,
    required this.title,
    required this.type,
    required this.price,
    required this.currency,
    required this.duration,
    required this.inclusions,
    required this.exclusions,
    required this.imageUrl,
    required this.rating,
    required this.isPopular,
    required this.isRecommended,
  });
  
  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      price: json['price'].toDouble(),
      currency: json['currency'],
      duration: json['duration'],
      inclusions: List<String>.from(json['inclusions']),
      exclusions: List<String>.from(json['exclusions']),
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      isPopular: json['isPopular'] ?? false,
      isRecommended: json['isRecommended'] ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'price': price,
      'currency': currency,
      'duration': duration,
      'inclusions': inclusions,
      'exclusions': exclusions,
      'imageUrl': imageUrl,
      'rating': rating,
      'isPopular': isPopular,
      'isRecommended': isRecommended,
    };
  }
}