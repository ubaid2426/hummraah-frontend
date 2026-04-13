import 'package:flutter/material.dart';
import 'package:hummraah/features/auth/presentation/pages/Quick_Service/assistance_screen.dart';
import 'package:hummraah/features/auth/presentation/pages/Quick_Service/hotel_screen.dart';
import 'package:hummraah/features/auth/presentation/pages/Quick_Service/tramsport_screen.dart';
import 'package:hummraah/features/auth/presentation/pages/Quick_Service/visa_screen.dart';
import '../../../../core/localization/app_localizations.dart';
import '../pages/Quick_Service/flight_screen.dart';
import '../pages/packages_screen.dart';

class QuickServicesGrid extends StatelessWidget {
  QuickServicesGrid({super.key});

  final List<Map<String, dynamic>> services = [
    {
      'icon': Icons.flight_rounded,
      'label': 'flights',
      'color': const Color(0xFF2C5F2D),
    },
    {
      'icon': Icons.hotel_rounded,
      'label': 'hotels',
      'color': const Color(0xFFE6B566),
    },
    {
      'icon': Icons.iso_rounded,
      'label': 'visa',
      'color': const Color(0xFFC44536),
    },
    {
      'icon': Icons.directions_bus_rounded,
      'label': 'transport',
      'color': const Color(0xFF4A6FA5),
    },
    {
      'icon': Icons.calculate_rounded,
      'label': 'packages',
      'color': const Color(0xFFB9805E),
    },
    {
      'icon': Icons.accessible_rounded,
      'label': 'assistance',
      'color': const Color(0xFF6B4F3C),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.translate('quick_services'),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C5F2D),
          ),
        ),
        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: service['color'].withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: service['color'].withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),

                  onTap: () {
                    Widget screen;

                    switch (index) {
                      case 0:
                        screen = FlightsScreen();
                        break;

                      case 1:
                        screen = HotelsScreen();
                        break;

                      case 2:
                        screen = VisaScreen();
                        break;

                      case 3:
                        screen = TransportScreen();
                        break;

                      case 4:
                        screen = PackagesScreen();
                        break;

                      case 5:
                        screen = AssistanceScreen();
                        break;

                      default:
                        screen = PackagesScreen();
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => screen,
                      ),
                    );
                  },

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: service['color'].withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          service['icon'],
                          color: service['color'],
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.translate(service['label']),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: service['color'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}