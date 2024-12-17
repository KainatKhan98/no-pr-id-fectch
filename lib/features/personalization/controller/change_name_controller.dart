import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/data/repositories/user_repository.dart';
import 'package:pet/features/personalization/controller/user_controller.dart';
import 'package:pet/features/personalization/screens/profile/profile.dart';
import 'package:pet/utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
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
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialogue('We are updating your information', loader);

      // Form Validation
      if(!updateUserNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Update first and last name
      Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);
      
      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      
      // Remove Loader
      FullScreenLoader.stopLoading();
      
      // Show Success Message
      Loaders.successSnackBar(title: "Congratulations", message: "Your Name has been updated");
      
      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
