import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet/data/repositories/authentication_repository.dart';
import 'package:pet/features/personalization/controller/user_controller.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../constants/images.dart';
import '../../../utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {

  // variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final controller = Get.put(UserController());

  User? user;

  // Email and Password Login
  Future<void> emailAndPasswordSignIn() async {
    try{
      // Start Loading
      FullScreenLoader.openLoadingDialogue("Logging you in...", loader);

      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      // if(!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
      }

      // Save Data for Remember Me
      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      // Login user in email and Password
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Google Sign In
  Future<void> googleSignIn() async {
    try{
      // Start loading
      FullScreenLoader.openLoadingDialogue('Logging you in...', loader);

      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await UserController.instance.saveUserRecord(userCredentials);

      // Remove loader
      FullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
