import 'package:flutter/material.dart';

class TranslatedTextWidget extends StatelessWidget {
  const TranslatedTextWidget({
    super.key,
    required this.arabicText,
    required this.englishText,
    this.textStyle,
  });
  final String arabicText;
  final String englishText;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return Text(
      locale.languageCode == 'ar' ? arabicText : englishText,
      style: textStyle,
    );
  }
}

String translatedText({
  required BuildContext context,
  required arabicText,
  required englishText,
}) {
  final locale = Localizations.localeOf(context);
  return locale.languageCode == 'ar' ? arabicText : englishText;
}
