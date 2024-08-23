import 'package:flutter/material.dart';

import '../style/app_style_text.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        headlineLarge: AppStyleText.headingLg(context),
        headlineMedium: AppStyleText.headingMd(context),
        headlineSmall: AppStyleText.headingSm(context),
        bodyLarge: AppStyleText.bodyLg(context),
        bodyMedium: AppStyleText.bodyMd(context),
        bodySmall: AppStyleText.bodySm(context),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(AppStyleText.button(context)),
        ),
      ),
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
