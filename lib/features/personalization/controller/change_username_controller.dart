import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/data/repositories/user_repository.dart';
import 'package:pet/features/personalization/controller/user_controller.dart';
import 'package:pet/features/personalization/screens/profile/profile.dart';
import 'package:pet/utils/popups/full_screen_loader.dart';

class UpdateUsernameController extends GetxController {
  static UpdateUsernameController get instance => Get.find();

  final username = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch User Record
  Future<void> initializeNames() async {
    username.text = userController.user.value.username;
  }

  Future<void> updateUserUsername() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialogue('We are updating your information', loader);

      // Form Validation
      if(!updateUserNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Update username
      Map<String, dynamic> name = {'Username': username.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.username = username.text.trim();

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: "Congratulations", message: "Your Username has been updated");

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
