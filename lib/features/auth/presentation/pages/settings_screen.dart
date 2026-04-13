// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
import '../../providers/language_provider.dart';
// import '../utils/colors.dart';
// import '../utils/constants.dart';
// import '../providers/theme_provider.dart';
// import '../providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          _buildSectionHeader('Appearance'),
          _buildSwitchTile(
            icon: Icons.dark_mode_rounded,
            title: 'Dark Mode',
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
          _buildSwitchTile(
            icon: Icons.brightness_auto_rounded,
            title: 'Follow System Theme',
            value: themeProvider.followSystemTheme,
            onChanged: (value) {
              themeProvider.setFollowSystemTheme(value);
            },
          ),
          const Divider(height: 32),

          // Language Section
          _buildSectionHeader('Language'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.language_rounded, color: Color(0xFF2C5F2D)),
            ),
            title: const Text('App Language'),
            subtitle: Text(_getLanguageName(languageProvider.currentLanguage)),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              _showLanguageDialog(context);
            },
          ),
          const Divider(height: 32),

          // Notifications Section
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(
            icon: Icons.notifications_active_rounded,
            title: 'Push Notifications',
            value: true,
            onChanged: (value) {},
          ),
          _buildSwitchTile(
            icon: Icons.access_time_rounded,
            title: 'Prayer Time Reminders',
            value: true,
            onChanged: (value) {},
          ),
          _buildSwitchTile(
            icon: Icons.mosque_rounded,
            title: 'Umrah Tips & Reminders',
            value: true,
            onChanged: (value) {},
          ),
          const Divider(height: 32),

          // Accessibility Section
          _buildSectionHeader('Accessibility'),
          _buildSliderTile(
            icon: Icons.text_fields_rounded,
            title: 'Font Size',
            value: 1.0,
            min: 0.8,
            max: 1.5,
            onChanged: (value) {},
          ),
          _buildSwitchTile(
            icon: Icons.volume_up_rounded,
            title: 'Voice Guidance',
            value: false,
            onChanged: (value) {},
          ),
          _buildSwitchTile(
            icon: Icons.vibration_rounded,
            title: 'Haptic Feedback',
            value: true,
            onChanged: (value) {},
          ),
          const Divider(height: 32),

          // Data & Storage
          _buildSectionHeader('Data & Storage'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.download_rounded, color: Color(0xFF4A6FA5)),
            ),
            title: const Text('Downloaded Content'),
            subtitle: const Text('Duas, Guides, Maps • 45 MB'),
            trailing: TextButton(
              onPressed: () {},
              child: const Text('Clear'),
            ),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.cached_rounded, color: Color(0xFFE6B566)),
            ),
            title: const Text('Clear Cache'),
            subtitle: const Text('Free up space • 23 MB'),
            trailing: TextButton(
              onPressed: () {},
              child: const Text('Clear'),
            ),
          ),
          const Divider(height: 32),

          // About Section
          _buildSectionHeader('About'),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.info_rounded, color: Color(0xFF2C5F2D)),
            ),
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.privacy_tip_rounded, color: Color(0xFF2C5F2D)),
            ),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.description_rounded, color: Color(0xFF2C5F2D)),
            ),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primaryGreen, size: 20),
      ),
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.primaryGreen,
    );
  }

  Widget _buildSliderTile({
    required IconData icon,
    required String title,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryGreen, size: 20),
          ),
          title: Text(title),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text('A', style: TextStyle(fontSize: 12)),
              Expanded(
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: 7,
                  onChanged: onChanged,
                  activeColor: AppColors.primaryGreen,
                ),
              ),
              const Text('A', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ur':
        return 'اردو';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                Provider.of<LanguageProvider>(context, listen: false).changeLanguage('en');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('اردو'),
              onTap: () {
                Provider.of<LanguageProvider>(context, listen: false).changeLanguage('ur');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('العربية'),
              onTap: () {
                Provider.of<LanguageProvider>(context, listen: false).changeLanguage('ar');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}