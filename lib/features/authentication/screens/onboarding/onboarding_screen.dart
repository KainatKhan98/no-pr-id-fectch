import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/constants/text.dart';
import 'package:pet/features/authentication/screens/onboarding/widgets/onboarding_navigation.dart';
import 'package:pet/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:pet/features/authentication/screens/onboarding/widgets/onboarding_pages.dart';
import '../../../../constants/images.dart';
import '../../controllers/onboarding_controller.dart';
import 'widgets/onboarding_skip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          //Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: onboardingImage1,
                title: onboardingTitle1,
                subtitle: onboardingSubTitle1,
              ),
              OnBoardingPage(
                image: onboardingImage2,
                title: onboardingTitle2,
                subtitle: onboardingSubTitle2,
              ),
              OnBoardingPage(
                image: onboardingImage3,
                title: onboardingTitle3,
                subtitle: onboardingSubTitle3,
              ),
            ],
          ),

          //Skip
          const OnBoardingSkip(),

          //Dot Navigation
          const OnBoardingNavigaton(),

          //Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
