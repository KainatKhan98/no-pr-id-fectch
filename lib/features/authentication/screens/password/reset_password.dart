import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/features/authentication/controllers/forget_password_controller.dart';
import 'package:pet/features/authentication/screens/login/login.dart';

import '../../../../constants/text.dart';
import '../../../../utils/helpers/helpers.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultPadding),
          child: Column(
            children: [
              Image(image: const AssetImage(verifyEmailImage), width: HelpFunctions.screenWidth()*0.8,),
              SizedBox(height: Sizes.m),

              // Title and Subtitle
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
              SizedBox(height: Sizes.s),
              Text(passemail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              SizedBox(height: Sizes.s),
              Text(passemailbody, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,),
              SizedBox(height: Sizes.l),

              // Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()), child: const Text('Done')),),
              SizedBox(height: Sizes.s),
              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordRestEmail(email), child: const Text(resend)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
