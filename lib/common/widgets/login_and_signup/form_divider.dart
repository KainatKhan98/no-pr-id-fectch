import 'package:flutter/material.dart';
import '../../../../../constants/colors.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key, required this.dividerText
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: logoPurple.withOpacity(0.7), thickness: 0.5, indent: 60, endIndent: 5,)),
        Text(dividerText, style: const TextStyle(color: logoPurple, fontSize: 12)),
        Flexible(child: Divider(color: logoPurple.withOpacity(0.7), thickness: 0.5, indent: 5, endIndent: 60,)),
      ],
    );
  }
}