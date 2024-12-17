import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/common/widgets/circular_image/circular_image.dart';
import 'package:pet/common/widgets/section_heading/section_heading.dart';
import 'package:pet/common/widgets/shimmer/shimmer_effect.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/features/personalization/controller/user_controller.dart';
import 'package:pet/features/personalization/screens/profile/widgets/change_email.dart';
import 'package:pet/features/personalization/screens/profile/widgets/change_phone_number.dart';
import 'package:pet/features/personalization/screens/profile/widgets/change_username.dart';
import 'package:pet/features/personalization/screens/profile/widgets/profile_menu.dart';

import '../../../../constants/images.dart';
import 'widgets/change_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Profile", style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      ),

      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultPadding),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : avatar;
                      return controller.imageUploading.value
                        ? const ShimmerEffect(width: 100, height: 100, radius: 80,)
                        : CircularImage(image: image, width: 100, height: 100, isNetworkImage: networkImage.isNotEmpty,);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: Text('Change Profile Picture', style: Theme.of(context).textTheme.bodySmall,)),
                  ],
                ),
              ),

              // Details
              SizedBox(height: Sizes.s,),
              const Divider(),
              SizedBox(height: Sizes.s*1.5,),
              const SectionHeading(title: 'Profile Information', showActionButton: false,),
              SizedBox(height: Sizes.m,),

              ProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
              ProfileMenu(title: 'Username', value: controller.user.value.username, onPressed: () => Get.to(() => const ChangeUsername())),

              SizedBox(height: Sizes.s,),
              const Divider(),
              SizedBox(height: Sizes.s*1.5,),

              // Personal Info
              const SectionHeading(title: 'Personal Information', showActionButton: false,),
              SizedBox(height: Sizes.m,),

              ProfileMenu(title: 'User ID', value: controller.user.value.id, icon:Iconsax.copy, onPressed: () =>  _copyToClipboard(context),),
              ProfileMenu(title: 'Email', value: controller.user.value.email, onPressed: () => Get.to(() => ChangeEmail(email: controller.user.value.email,))),
              ProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNo, onPressed: () => Get.to(() => const ChangePhoneNumber())),

              SizedBox(height: Sizes.s,),
              const Divider(),
              SizedBox(height: Sizes.s*1.5,),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWaningPop(),
                  child: const Text('Close Account',  style: TextStyle(color: Colors.red),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _copyToClipboard(BuildContext context) {
  const String codeToCopy = '';
  Clipboard.setData(const ClipboardData(text: codeToCopy));
}














