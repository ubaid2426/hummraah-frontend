// lib/widgets/language_selector.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
// import '../providers/language_provider.dart';
// import '../utils/constants.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Language',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          ...AppConstants.languages.map((lang) {
            return ListTile(
              leading: Text(
                lang['flag']!,
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(lang['name']!),
              trailing: languageProvider.currentLanguage == lang['code']
                  ? const Icon(Icons.check_circle_rounded, color: Color(0xFF2C5F2D))
                  : null,
              onTap: () {
                languageProvider.changeLanguage(lang['code']!);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}