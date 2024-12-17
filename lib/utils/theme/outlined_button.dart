import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class OutlinedButtTheme {
  OutlinedButtTheme._();

  static final lightOutlinedButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: logoPurple,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      textStyle: const TextStyle(fontSize: 18, color: logoPurple),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      side: const BorderSide(color: logoPurple,)
    ),
  );
}
