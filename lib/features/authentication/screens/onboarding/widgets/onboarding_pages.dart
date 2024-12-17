import 'package:flutter/material.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../utils/helpers/helpers.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.m),
      child: Column(
        children: [
          Image(
              width: HelpFunctions.screenWidth() * 0.8,
              height: HelpFunctions.screenHeight() * 0.5,
              image: AssetImage(image)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: Sizes.m),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}