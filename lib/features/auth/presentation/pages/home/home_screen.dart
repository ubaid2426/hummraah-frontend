// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/language_provider.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/drawers_main.dart';
import '../../widgets/hero_banner.dart';
import '../../widgets/journey_timeline.dart';
import '../../widgets/local_services.dart';
import '../../widgets/quick_services_grid.dart';
import '../../widgets/religious_tools.dart';
import '../../widgets/smart_features.dart';
import '../../widgets/spiritual_content.dart';
import '../../widgets/ziyarah_planner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final t = AppLocalizations.of(context);

    return Scaffold(
      drawer: MainDrawer(),
      body: SafeArea(
        child: Directionality(
          textDirection: languageProvider.isRTL()
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar with greeting and language
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                // leading: Padding(
                //   padding: const EdgeInsets.all(8.0),
                  
                // ),
                title: Column(
                  crossAxisAlignment: languageProvider.isRTL()
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.translate('assalamu_alaikum'),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      authProvider.isAuthenticated
                          ? authProvider.currentUser?.name ??
                                t.translate('guest')
                          : t.translate('guest'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C5F2D),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      _showLanguageDialog(context, languageProvider);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFE6B566).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _getLanguageFlag(languageProvider.currentLanguage),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF2C5F2D),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Main Content
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 8),

                    // Hero Section with Countdown
                    const HeroBanner(),

                    const SizedBox(height: 24),

                    // Journey Timeline
                    const JourneyTimeline(),

                    const SizedBox(height: 24),

                    // Quick Services
                    QuickServicesGrid(),

                    const SizedBox(height: 24),

                    // Religious Tools
                    const ReligiousTools(),

                    const SizedBox(height: 24),

                    // Ziyarah Planner Preview
                    const ZiyarahPlanner(),

                    const SizedBox(height: 24),

                    // Local Services
                    const LocalServices(),

                    const SizedBox(height: 24),

                    // Smart Features
                    const SmartFeatures(),

                    const SizedBox(height: 24),

                    // Spiritual Content
                    const SpiritualContent(),

                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 0),
    );
  }

  String _getLanguageFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'ur':
        return '🇵🇰';
      case 'ar':
        return '🇸🇦';
      default:
        return '🇺🇸';
    }
  }

  void _showLanguageDialog(
    BuildContext context,
    LanguageProvider languageProvider,
  ) {
    final t = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t.translate('select_language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: const Text('English'),
                onTap: () {
                  languageProvider.changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇵🇰', style: TextStyle(fontSize: 24)),
                title: const Text('اردو'),
                onTap: () {
                  languageProvider.changeLanguage('ur');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: const Text('العربية'),
                onTap: () {
                  languageProvider.changeLanguage('ar');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
