import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/data/repositories/user_repository.dart';
import 'package:pet/features/personalization/controller/user_controller.dart';
import 'package:pet/features/personalization/screens/profile/profile.dart';
import 'package:pet/utils/popups/full_screen_loader.dart';

class UpdatePhoneController extends GetxController {
  static UpdatePhoneController get instance => Get.find();

  final phone = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch User Record
  Future<void> initializeNames() async {
    phone.text = userController.user.value.phoneNo;
  }

  Future<void> updatePhone() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialogue('We are updating your information', loader);

      // Form Validation
      if(!updatePhoneFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Update username
      Map<String, dynamic> name = {'PhoneNo': phone.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.phoneNo = phone.text.trim();

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: "Congratulations", message: "Your Phone Number has been updated");

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
