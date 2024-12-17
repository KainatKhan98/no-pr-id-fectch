import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';

class TextFormFieldThemes {
  TextFormFieldThemes._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    prefixIconColor: textColor,
    suffixIconColor: textColor,
    labelStyle: const TextStyle().copyWith(fontSize: 12, color: textColor),
    hintStyle: const TextStyle().copyWith(fontSize: 12, color: textColor),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: textColor.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 1, color: textColor),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 1, color: textColor),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 1.5, color: textColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 1.5, color: Colors.orange),
    ),
  );
}