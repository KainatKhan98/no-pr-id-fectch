import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/common/widgets/section_heading/section_heading.dart';
import 'package:pet/data/repositories/authentication_repository.dart';
import 'package:pet/features/personalization/screens/profile/profile.dart';
import 'package:pet/features/personalization/screens/settings/widgets/settings_menu_tile.dart';
import 'package:pet/features/personalization/screens/settings/widgets/user_profile_card.dart';
import 'package:pet/utils/helpers/helpers.dart';
import '../../../../constants/colors.dart';
import '../../../personalization/controller/user_controller.dart';

class ProviderSettingScreen extends StatelessWidget {
  const ProviderSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      backgroundColor: logoPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AppBar
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Account", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),),
              ),
            ),

            // Profile Card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UserProfileCard(onPressed: () => Get.to(()=> const ProfileScreen())),
            ),
            SizedBox(height: Sizes.s,),

            // Body
            Container(
              width: HelpFunctions.screenWidth(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.all(Sizes.defaultPadding),
                child: Column(
                  children: [
                    // Account Settings
                    const SectionHeading(title: "Account Settings", showActionButton: false,),
                    SizedBox(height: Sizes.s,),
                    const SettingsMenuTile(icon: Iconsax.calendar_1, title: 'My Appointments',),
                    const SettingsMenuTile(icon: Iconsax.receipt, title: 'My Orders', ),
                    const SettingsMenuTile(icon: Iconsax.star, title: 'My Reviews', ),
                    const SettingsMenuTile(icon: Iconsax.document, title: 'My Certificates', ),
                    const SettingsMenuTile(icon: Iconsax.task, title: 'My Listings', ),
                    const SettingsMenuTile(icon: Iconsax.book, title: 'My Blogs', ),
                    const SettingsMenuTile(icon: Iconsax.box, title: 'My Products', ),
                    const SettingsMenuTile(icon: Iconsax.lock, title: 'Privacy Policy', ),
                    const SettingsMenuTile(icon: Iconsax.document_code, title: 'Terms and Conditions', ),
                    const SettingsMenuTile(icon: Iconsax.star, title: 'Rate App', ),
                    const SettingsMenuTile(icon: Icons.contacts, title: 'Contact Us', ),
                    SettingsMenuTile(icon: Iconsax.logout, title: 'Logout', onTap: AuthenticationRepository.instance.logout),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}

