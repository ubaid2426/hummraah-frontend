 // import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'core/di/service_locator.dart' as di;
// import 'features/auth/presentation/bloc/auth_bloc.dart';
// import 'features/auth/presentation/pages/login_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await di.init();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider(
//         create: (_) => di.sl<AuthBloc>(),
//         child: LoginPage(),
//       ),
//     );
//   }
// }





// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'features/auth/presentation/pages/home/home_screen.dart';
// // import 'package:hummraah/features/auth/presentation/pages/home/home_screen.dart';
// // import 'screens/home_screen.dart';

// void main() {
//   runApp(const HummraahApp());
// }

// class HummraahApp extends StatelessWidget {
//   const HummraahApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hummraah - Umrah Companion',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         fontFamily: 'Poppins',
//         scaffoldBackgroundColor: const Color(0xFFF8F5F0),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle.dark,
//         ),
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }





// lib/main.dart (updated)
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// import 'core/localization/app_localizations.dart';
// import 'core/services/local_storage_service.dart';
// import 'core/services/notification_service.dart';
// import 'core/utils/themes.dart';
// import 'features/auth/data/models/location_model.dart';
// import 'features/auth/presentation/pages/booking_screen.dart';
// import 'features/auth/presentation/pages/dua_screen.dart';
// import 'features/auth/presentation/pages/home/home_screen.dart';
// import 'features/auth/presentation/pages/notifications_screen.dart';
// import 'features/auth/presentation/pages/packages_screen.dart';
// import 'features/auth/presentation/pages/payment_screen.dart';
// import 'features/auth/presentation/pages/planner_screen.dart';
// import 'features/auth/presentation/pages/prayer_times_screen.dart';
// import 'features/auth/presentation/pages/profile_screen.dart';
// import 'features/auth/presentation/pages/services_screen.dart';
// import 'features/auth/presentation/pages/settings_screen.dart';
// import 'features/auth/presentation/pages/splash/splash_page.dart';
// import 'features/auth/presentation/pages/tawaf_counter_screen.dart';
// import 'features/auth/presentation/pages/umrah_guide_screen.dart';
// import 'features/auth/presentation/pages/ziyarah_detail_screen.dart';
// import 'features/auth/providers/auth_provider.dart';
// import 'features/auth/providers/journey_provider.dart';
// import 'features/auth/providers/language_provider.dart';
// import 'features/auth/providers/prayer_times_provider.dart';
// import 'features/auth/providers/theme_provider.dart';

// void main() async {
//     // Suppress specific Flutter framework errors
//   if (kDebugMode) {
//     FlutterError.onError = (FlutterErrorDetails details) {
//       // Ignore the keyboard key event error
//       if (details.exceptionAsString().contains('KeyUpEvent') && 
//           details.exceptionAsString().contains('physical key is not pressed')) {
//         // Suppress this specific error
//         return;
//       }
//       // For other errors, show them normally
//       FlutterError.presentError(details);
//     };
//   }
//   WidgetsFlutterBinding.ensureInitialized();
  
//   // Initialize services
//   await LocalStorageService().init();
//   // await NotificationService().init();
  
//   runApp(const HummraahApp());
// }

// class HummraahApp extends StatelessWidget {
//   const HummraahApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//         ChangeNotifierProvider(create: (_) => LanguageProvider()),
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => JourneyProvider()),
//         // ChangeNotifierProvider(create: (_) => PrayerTimesProvider()),
//       ],
//       child: Consumer2<ThemeProvider, LanguageProvider>(
//         builder: (context, themeProvider, languageProvider, child) {
//           return MaterialApp(
//             title: 'Hummraah',
//             debugShowCheckedModeBanner: false,
//             theme: AppTheme.lightTheme,
//             darkTheme: AppTheme.darkTheme,
//             themeMode: themeProvider.themeMode,
//             locale: languageProvider.locale,
//             localizationsDelegates: const [
//               AppLocalizations.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: const [
//               Locale('en', ''),
//               Locale('ur', ''),
//               Locale('ar', ''),
//             ],
//             initialRoute: '/',
//             onGenerateRoute: (settings) {
//               switch (settings.name) {
//                 case '/':
//                   return MaterialPageRoute(builder: (_) => const HomeScreen());
//                 case '/packages':
//                   return MaterialPageRoute(builder: (_) => const PackagesScreen());
//                 case '/planner':
//                   return MaterialPageRoute(builder: (_) => const PlannerScreen());
//                 case '/services':
//                   return MaterialPageRoute(builder: (_) => const ServicesScreen());
//                 case '/profile':
//                   return MaterialPageRoute(builder: (_) => const ProfileScreen());
//                 case '/dua':
//                   return MaterialPageRoute(builder: (_) => const DuaScreen());
//                 case '/prayer-times':
//                   return MaterialPageRoute(builder: (_) => const PrayerTimesScreen());
//                 case '/umrah-guide':
//                   return MaterialPageRoute(builder: (_) => const UmrahGuideScreen());
//                 case '/tawaf-counter':
//                   return MaterialPageRoute(builder: (_) => const TawafCounterScreen());
//                 case '/booking':
//                   return MaterialPageRoute(builder: (_) => const BookingScreen());
//                 case '/notifications':
//                   return MaterialPageRoute(builder: (_) => const NotificationsScreen());
//                 case '/settings':
//                   return MaterialPageRoute(builder: (_) => const SettingsScreen());
//                 case '/ziyarah-detail':
//                   if (settings.arguments is LocationModel) {
//                     return MaterialPageRoute(
//                       builder: (_) => ZiyarahDetailScreen(location: settings.arguments as LocationModel),
//                     );
//                   }
//                   return _errorRoute();
//                 case '/payment':
//                   if (settings.arguments is Map<String, dynamic>) {
//                     final args = settings.arguments as Map<String, dynamic>;
//                     return MaterialPageRoute(
//                       builder: (_) => PaymentScreen(
//                         amount: args['amount'] ?? 0.0,
//                         currency: args['currency'] ?? 'USD',
//                       ),
//                     );
//                   }
//                   return _errorRoute();
//                 default:
//                   return _errorRoute();
//               }
//             },
//             // home: const SplashScreen(),
//             home: const HomeScreen(),
//           );
//         },
//       ),
//     );
//   }

//   Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Error'),
//         ),
//         body: const Center(
//           child: Text('Page not found'),
//         ),
//       );
//     });
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/di/service_locator.dart';

// Core
import 'core/localization/app_localizations.dart';
import 'core/services/local_storage_service.dart';
import 'core/utils/themes.dart';

// Providers
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/providers/journey_provider.dart';
import 'features/auth/providers/language_provider.dart';
import 'features/auth/providers/theme_provider.dart';

// Screens
import 'features/auth/presentation/pages/home/home_screen.dart';
import 'features/auth/presentation/pages/packages_screen.dart';
import 'features/auth/presentation/pages/planner_screen.dart';
import 'features/auth/presentation/pages/services_screen.dart';
import 'features/auth/presentation/pages/profile_screen.dart';
import 'features/auth/presentation/pages/dua_screen.dart';
import 'features/auth/presentation/pages/prayer_times_screen.dart';
import 'features/auth/presentation/pages/umrah_guide_screen.dart';
import 'features/auth/presentation/pages/tawaf_counter_screen.dart';
import 'features/auth/presentation/pages/booking_screen.dart';
import 'features/auth/presentation/pages/notifications_screen.dart';
import 'features/auth/presentation/pages/settings_screen.dart';
import 'features/auth/presentation/pages/splash/splash_page.dart';
import 'features/auth/presentation/pages/ziyarah_detail_screen.dart';
import 'features/auth/presentation/pages/payment_screen.dart';

// Models
import 'features/auth/data/models/location_model.dart';

// BLOC + CLEAN ARCH
import 'core/services/api/api_service.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/booking_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // suppress flutter noise (optional)
  if (kDebugMode) {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
    };
  }

  await LocalStorageService().init();
  await init();

  runApp(const HummraahApp());
}

class HummraahApp extends StatelessWidget {
  const HummraahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // providers: [
      //   // 🔵 THEME + LANGUAGE + OTHER PROVIDERS
      //   ChangeNotifierProvider(create: (_) => ThemeProvider()),
      //   ChangeNotifierProvider(create: (_) => LanguageProvider()),
      //   ChangeNotifierProvider(create: (_) => AuthProvider()),
      //   ChangeNotifierProvider(create: (_) => JourneyProvider()),

      //   // 🔥 BLOC (AUTH)
      //  BlocProvider<AuthBloc>(
      //     create: (_) => AuthBloc(
      //       Login(
      //         AuthRepositoryImpl(
      //           remoteDataSource: AuthRemoteDataSource(
      //             ApiService(), // 👈 FIX HERE (NO named parameter)
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => JourneyProvider()),

        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),

        BlocProvider<BookingBloc>(create: (_) => sl<BookingBloc>()),
      ],

      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            title: 'Hummraah',
            debugShowCheckedModeBanner: false,

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            locale: languageProvider.locale,

            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            supportedLocales: const [
              Locale('en', ''),
              Locale('ur', ''),
              Locale('ar', ''),
            ],

            initialRoute: '/',

            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(builder: (_) => const HomeScreen());

                case '/packages':
                  return MaterialPageRoute(
                    builder: (_) => const PackagesScreen(),
                  );

                case '/planner':
                  return MaterialPageRoute(
                    builder: (_) => const PlannerScreen(),
                  );

                case '/services':
                  return MaterialPageRoute(
                    builder: (_) => const ServicesScreen(),
                  );

                case '/profile':
                  return MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  );

                case '/dua':
                  return MaterialPageRoute(builder: (_) => const DuaScreen());

                case '/prayer-times':
                  return MaterialPageRoute(
                    builder: (_) => const PrayerTimesScreen(),
                  );

                case '/umrah-guide':
                  return MaterialPageRoute(
                    builder: (_) => const UmrahGuideScreen(),
                  );

                case '/tawaf-counter':
                  return MaterialPageRoute(
                    builder: (_) => const TawafCounterScreen(),
                  );

                case '/booking':
                  return MaterialPageRoute(
                    builder: (_) => const BookingScreen(),
                  );

                case '/notifications':
                  return MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  );

                case '/settings':
                  return MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  );

                case '/ziyarah-detail':
                  if (settings.arguments is LocationModel) {
                    return MaterialPageRoute(
                      builder: (_) => ZiyarahDetailScreen(
                        location: settings.arguments as LocationModel,
                      ),
                    );
                  }
                  return _errorRoute();

                case '/payment':
                  if (settings.arguments is Map<String, dynamic>) {
                    final args = settings.arguments as Map<String, dynamic>;
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
            },

            home: const HomeScreen(),
          );
        },
      ),
    );
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
