import 'package:flutter/material.dart';
import 'package:pet/features/authentication/controllers/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      child: SafeArea(
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: const Text("Skip", style: TextStyle(color: Colors.grey),),
        ),
      ),
    );
  }
}