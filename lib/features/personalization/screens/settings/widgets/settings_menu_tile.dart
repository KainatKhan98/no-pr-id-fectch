import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({super.key, required this.icon, required this.title, this.trailing, this.onTap});

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: textColor,),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium,),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
