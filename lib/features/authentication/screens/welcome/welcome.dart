import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet/constants/text.dart';
import '../../../../constants/images.dart';
import '../../../../constants/sizes.dart';
import '../../../../utils/helpers/helpers.dart';
import '../login/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Sizes.m),
        child: Column(
          children: [
            // image
            Center(
              child: Image(
                image: const AssetImage(welcomeImage),
                width: HelpFunctions.screenWidth() * 0.9,
                height: HelpFunctions.screenHeight() * 0.6,
              ),
            ),
            Column(
              children: [
                Text(welcomeText, style: Theme.of(context).textTheme.headlineLarge,),
                SizedBox(height: Sizes.m),
                // Pet Parent
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      // Save the role and navigate to Login/Signup
                      await saveRoleAndNavigate(role: 'pet_parent');
                    },
                    child: const Text("Pet Parent",),
                  ),
                ),
                SizedBox(height: Sizes.s),
                // Service Provider
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Save the role and navigate to Login/Signup
                      await saveRoleAndNavigate(role: 'provider');
                    },
                    child: const Text("Service Provider",),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> saveRoleAndNavigate({required String role}) async {
  // Save the selected role in local storage
  await GetStorage().write('userRole', role);

  // Navigate to the login/signup screen
  Get.to(() => const LoginScreen());
}




