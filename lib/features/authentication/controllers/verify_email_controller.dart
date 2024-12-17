import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/common/widgets/success_screen/success_screen.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/constants/text.dart';
import 'package:pet/data/repositories/authentication_repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit () {
    sendEmailVerification();
    setTimerForRedirection();
    super.onInit();
  }

  // Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Timer
  setTimerForRedirection() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(image: accountCreatedImage, title: created, subTitle: createdbody, onPressed: AuthenticationRepository.instance.screenRedirect));
      }
    });
  }

  // Manually check for Email verification
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(image: accountCreatedImage, title: created, subTitle: createdbody, onPressed: AuthenticationRepository.instance.screenRedirect));
    }
  }
}