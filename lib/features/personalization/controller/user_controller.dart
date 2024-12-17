import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/data/repositories/authentication_repository.dart';
import 'package:pet/data/repositories/user_repository.dart';
import 'package:pet/features/authentication/models/user_model.dart';
import 'package:pet/features/authentication/screens/login/login.dart';
import 'package:pet/features/personalization/screens/profile/widgets/re_authenticate.dart';
import 'package:pet/utils/popups/full_screen_loader.dart';

import '../../../constants/images.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch user record
  Future<void> fetchUserRecord() async  {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    }
  }

  // Save user record from any provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh User Record
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert name into first and last
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          // Map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : " ",
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNo: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user Data
          await userRepository.saveUserRecord(user);
        }
      }
    }
    catch (e) {
      Loaders.warningSnackBar(title: 'Data not saved!', message:'Something went wrong while saving your information. You can re-save your data in your profile');
    }
  }

  // Delete Account Warning
  void deleteAccountWaningPop() {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(Sizes.s*2),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently?',
      confirm: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Delete'),
          ),
        ),
      ),
      cancel: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Cancel'),
          ),
        ),
      )
    );
  }

  // Delete User Account
  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialogue('Processing', loader);

      // First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }

    } catch(e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Re-Authenticate before deleting
  Future<void> reAuthenticationEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialogue('Processing', loader);

      if(!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());

    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Upload Profile Picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if(image != null) {
        imageUploading.value = true;
        
        // Uploading Image
        final imageUrl = await userRepository.uploadImage('Users/images/Profile', image);

        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);
        
        user.value.profilePicture = imageUrl;
        user.refresh();
        
        Loaders.successSnackBar(title: "Congratulations", message: 'Your Profile Image has been updated');
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}