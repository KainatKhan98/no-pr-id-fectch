import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/data/repositories/user_repository.dart';
import 'package:pet/features/authentication/screens/signup/verify_email.dart';
import 'package:pet/utils/popups/full_screen_loader.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../models/user_model.dart';
// import '../../../common/widgets/network_manager/network_manager.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNo = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // SIGNUP

  void signup() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialogue('We are processing your information', loader);

      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      // if(!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      // Form Validation
      if(!signupFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy
      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
          title: "Accept Privacy Policy",
          message: "In order to create an account, you must have to accept the Privacy Policy & Terms of Use.",
        );
        FullScreenLoader.stopLoading();
        return;
      }

      // Register User
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save User
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        phoneNo: phoneNo.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      FullScreenLoader.stopLoading();

      // Show Success Message
      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(title: "Congratulations", message: "Your account has been created! Verify email to continue.");

      // Move to Verify Email Screen
      Get.to(() => VerifyEmail(email: email.text.trim(),));


    } catch (e) {
      FullScreenLoader.stopLoading();
      // Generic Error
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}