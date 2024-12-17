import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';

class ElevatedButtTheme {
  ElevatedButtTheme._();

  static final lightElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: logoPurple,
      padding: const EdgeInsets.symmetric(vertical: 15),
      textStyle: const TextStyle(fontSize: 18, color: Colors.white,),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    )
  );
}
