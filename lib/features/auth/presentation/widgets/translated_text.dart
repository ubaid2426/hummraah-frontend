// lib/widgets/translated_text.dart
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
// import '../localization/app_localizations.dart';

class TranslatedText extends StatelessWidget {
  // final String key;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  
  const TranslatedText(
   {super.key, 

    this.style,
    this.textAlign,
    this.maxLines, 
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Text(
      t.translate('key'),
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}