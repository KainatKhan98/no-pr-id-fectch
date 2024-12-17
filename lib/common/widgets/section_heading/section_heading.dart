import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key,
    this.showActionButton = true,
    required this.title,
    this.buttonTile = 'View All',
    this.onPressed});

  final bool showActionButton;
  final String title, buttonTile;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton) TextButton(onPressed: () {} , child: Text(buttonTile,  style: Theme.of(context).textTheme.bodySmall,)),
      ],
    );
  }
}
