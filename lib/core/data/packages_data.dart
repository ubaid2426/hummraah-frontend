// lib/data/packages_data.dart
import '../../features/auth/data/models/package_model.dart';
// import '../models/package_model.dart';

List<PackageModel> allPackages = [
  PackageModel(
    id: '1',
    title: 'Premium Umrah Package',
    type: 'Premium',
    price: 4500,
    currency: 'USD',
    duration: 14,
    inclusions: ['5* Hotel', 'Private Transport', 'Visa Processing', 'Guide', 'Meals'],
    exclusions: ['Airfare', 'Personal Expenses'],
    imageUrl: 'https://images.unsplash.com/photo-1542816417-0983c9c9ad53?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    rating: 4.8,
    isPopular: true,
    isRecommended: true,
  ),
  PackageModel(
    id: '2',
    title: 'Economy Umrah Package',
    type: 'Economy',
    price: 2500,
    currency: 'USD',
    duration: 10,
    inclusions: ['3* Hotel', 'Shared Transport', 'Visa Processing', 'Basic Guide'],
    exclusions: ['Meals', 'Airfare', 'Personal Expenses'],
    imageUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    rating: 4.2,
    isPopular: false,
    isRecommended: false,
  ),
  PackageModel(
    id: '3',
    title: 'Family Umrah Package',
    type: 'Family',
    price: 3800,
    currency: 'USD',
    duration: 12,
    inclusions: ['4* Hotel', 'Private Van', 'Visa Processing', 'Family Guide', 'Kids Activities'],
    exclusions: ['Airfare', 'Some Meals'],
    imageUrl: 'https://images.unsplash.com/photo-1584273143981-41c073dfe8f8?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    rating: 4.6,
    isPopular: true,
    isRecommended: true,
  ),
];