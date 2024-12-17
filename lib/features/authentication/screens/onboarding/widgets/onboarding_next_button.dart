import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/features/authentication/controllers/onboarding_controller.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: Sizes.m,
        bottom: 80,
        child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
              side: const BorderSide(
                color: logoPurple,
              ),
              backgroundColor: logoPurple,
              shape: const CircleBorder()
          ),
          child: const Icon(
            Iconsax.arrow_right_3,
            color: Colors.white,
          ),
        ));
  }
}