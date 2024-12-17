import 'package:flutter/material.dart';
import 'package:pet/utils/theme/elevated_button.dart';
import 'package:pet/utils/theme/outlined_button.dart';
import 'package:pet/utils/theme/text_fields.dart';
import 'package:pet/utils/theme/text_theme.dart';
import 'check_box.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    fontFamily: 'Ubuntu',
    scaffoldBackgroundColor: Colors.white,
    textTheme: PTextTheme.lightText,
    elevatedButtonTheme: ElevatedButtTheme.lightElevatedButton,
    outlinedButtonTheme: OutlinedButtTheme.lightOutlinedButton,
    checkboxTheme: CheckBoxTheme.lightCheckBox,
    inputDecorationTheme: TextFormFieldThemes.lightInputDecorationTheme,
  );
}