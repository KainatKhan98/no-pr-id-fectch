import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';

class CheckBoxTheme {
  CheckBoxTheme._();

  static CheckboxThemeData lightCheckBox = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return logoPurple;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return logoPurple;
      } else {
        return Colors.transparent;
      }
    }),
    side: WidgetStateBorderSide.resolveWith(
          (states) {
        // return const BorderSide(color: textColor); // Border color
            if (states.contains(WidgetState.selected)) {
              return const BorderSide(color: logoPurple);
            } else {
            return const BorderSide(color: textColor);
            }
      },
    ),
  );
}