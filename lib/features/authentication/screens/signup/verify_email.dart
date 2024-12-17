import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/data/repositories/authentication_repository.dart';
import 'package:pet/features/authentication/controllers/verify_email_controller.dart';
import 'package:pet/utils/helpers/helpers.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () =>AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultPadding),
          child: Column(
            children: [
              // Image
              Image(
                image: const AssetImage(verifyEmailImage),
                width: HelpFunctions.screenWidth() * 0.7,
              ),
              SizedBox(height: Sizes.m),

              // Title and Subtitle
              Text(
                verify,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Sizes.s),
              Text(email ?? '', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,),
              SizedBox(height: Sizes.s),
              Text(
                verifybody,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Sizes.l),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    child: const Text(continu)),
              ),
              SizedBox(height: Sizes.s),
              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: () => controller.sendEmailVerification(), child: const Text(resend)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
