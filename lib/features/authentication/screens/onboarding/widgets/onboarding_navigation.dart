import 'package:flutter/material.dart';
import 'package:pet/features/authentication/controllers/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';

class OnBoardingNavigaton extends StatelessWidget {
  const OnBoardingNavigaton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
        bottom: Sizes.xl,
        left: Sizes.m,
        child:
        SmoothPageIndicator(
          count: 3,
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          effect: const ExpandingDotsEffect(
              activeDotColor: logoPurple,
              dotHeight: 6
          ),
        )
    );
  }
}