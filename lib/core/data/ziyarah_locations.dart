// lib/data/ziyarah_locations.dart
import '../../features/auth/data/models/location_model.dart';
// import '../models/location_model.dart';

List<LocationModel> ziyarahLocations = [
  LocationModel(
    id: '1',
    name: 'Masjid al-Haram',
    nameArabic: 'المسجد الحرام',
    description: 'The Great Mosque of Mecca, surrounding the Kaaba',
    imageUrl: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    latitude: 21.4225,
    longitude: 39.8262,
    type: 'masjid',
    city: 'Makkah',
    rating: 5.0,
    reviewCount: 1250,
    openingHours: ['24 hours', '7 days a week'],
    isWheelchairAccessible: true,
    contactNumber: '+966 12 573 3333',
    features: ['Wudu Areas', 'Prayer Mats', 'Quran Copies', 'Guided Tours'],
  ),
  LocationModel(
    id: '2',
    name: 'Masjid an-Nabawi',
    nameArabic: 'المسجد النبوي',
    description: 'The Prophet\'s Mosque in Medina',
    imageUrl: 'https://images.unsplash.com/photo-1591604129932-5e03a6d0e8a4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    latitude: 24.4672,
    longitude: 39.6111,
    type: 'masjid',
    city: 'Madinah',
    rating: 5.0,
    reviewCount: 980,
    openingHours: ['24 hours', '7 days a week'],
    isWheelchairAccessible: true,
    contactNumber: '+966 14 822 2000',
    features: ['Rawdah Access', 'Umbrellas', 'Wudu Areas', 'Guided Tours'],
  ),
];