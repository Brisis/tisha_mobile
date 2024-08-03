import 'package:flutter/material.dart';
import 'package:tisha_app/theme/colors.dart';

abstract class CustomTypography {
  static TextTheme textTheme = TextTheme(
    bodySmall: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: CustomColors.kMediumTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.normal,
      color: CustomColors.kLightTextColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(fontSize: 8),
    labelMedium: TextStyle(fontSize: 10),
    labelLarge: TextStyle(fontSize: 12),
    displaySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: CustomColors.kBoldTextColor,
    ),
  );
}
