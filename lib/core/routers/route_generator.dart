// lib/routes/route_generator.dart
import 'package:flutter/material.dart';
import '../../features/auth/data/models/location_model.dart';
import '../../features/auth/presentation/pages/booking_screen.dart';
import '../../features/auth/presentation/pages/dua_screen.dart';
import '../../features/auth/presentation/pages/home/home_screen.dart';
import '../../features/auth/presentation/pages/notifications_screen.dart';
import '../../features/auth/presentation/pages/packages_screen.dart';
import '../../features/auth/presentation/pages/payment_screen.dart';
import '../../features/auth/presentation/pages/planner_screen.dart';
import '../../features/auth/presentation/pages/prayer_times_screen.dart';
import '../../features/auth/presentation/pages/profile_screen.dart';
import '../../features/auth/presentation/pages/services_screen.dart';
import '../../features/auth/presentation/pages/settings_screen.dart';
import '../../features/auth/presentation/pages/tawaf_counter_screen.dart';
import '../../features/auth/presentation/pages/umrah_guide_screen.dart';
import '../../features/auth/presentation/pages/ziyarah_detail_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
        
      case AppRoutes.packages:
        return MaterialPageRoute(builder: (_) => const PackagesScreen());
        
      case AppRoutes.planner:
        return MaterialPageRoute(builder: (_) => const PlannerScreen());
        
      case AppRoutes.services:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());
        
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
        
      case AppRoutes.dua:
        return MaterialPageRoute(builder: (_) => const DuaScreen());
        
      case AppRoutes.prayerTimes:
        return MaterialPageRoute(builder: (_) => const PrayerTimesScreen());
        
      case AppRoutes.umrahGuide:
        return MaterialPageRoute(builder: (_) => const UmrahGuideScreen());
        
      case AppRoutes.tawafCounter:
        return MaterialPageRoute(builder: (_) => const TawafCounterScreen());
        
      case AppRoutes.booking:
        return MaterialPageRoute(builder: (_) => const BookingScreen());
        
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
        
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
        
      case AppRoutes.ziyarahDetail:
        if (args is LocationModel) {
          return MaterialPageRoute(
            builder: (_) => ZiyarahDetailScreen(location: args),
          );
        }
        return _errorRoute();
        
      case AppRoutes.payment:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => PaymentScreen(
              amount: args['amount'] ?? 0.0,
              currency: args['currency'] ?? 'USD',
            ),
          );
        }
        return _errorRoute();
        
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}