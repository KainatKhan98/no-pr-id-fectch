import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';

class PTextTheme {
  PTextTheme._();

  static TextTheme lightText = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 30, fontWeight: FontWeight.bold, color: textColor),
    headlineMedium: const TextStyle().copyWith(fontSize: 23, fontWeight: FontWeight.w700, color: textColor),
    headlineSmall: const TextStyle().copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: textColor),

    bodyLarge: const TextStyle().copyWith(fontSize: 17, fontWeight: FontWeight.w500, color: textColor),
    bodyMedium: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: textColor),
    bodySmall: const TextStyle().copyWith(fontSize: 12, color: textColor),
  );
}