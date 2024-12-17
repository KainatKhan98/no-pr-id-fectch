import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/data/repositories/authentication_repository.dart';
import 'package:pet/features/authentication/screens/password/reset_password.dart';
import 'package:pet/utils/popups/full_screen_loader.dart';

import '../../../constants/images.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  sendPasswordRestEmail() async {
    try {
      // Start loading
      FullScreenLoader.openLoadingDialogue('Processing Your Request...', loader);

      // Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()) {
       FullScreenLoader.stopLoading();
       return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Screen
      Loaders.successSnackBar(title: 'Email Sent!', message: 'Email link sent to Reset Your Password');

      // Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    }
    catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordRestEmail(String email) async {
    try{
      // Start loading
      FullScreenLoader.openLoadingDialogue('Processing Your Request...', loader);

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Screen
      Loaders.successSnackBar(title: 'Email Sent!', message: 'Email link sent to Reset Your Password');
    }
    catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}