import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/constants/sizes.dart';

class AppointmentSection extends StatelessWidget {
  const AppointmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Appointments",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}


