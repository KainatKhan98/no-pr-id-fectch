import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/features/authentication/controllers/forget_password_controller.dart';
import 'package:pet/utils/validators/validation.dart';
import '../../../../constants/text.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body:
      Padding(
        padding: EdgeInsets.all(Sizes.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(forgotpass, style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: Sizes.s,),
            Text(forgotpassbody, style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: Sizes.l,),

            // Text Fields
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: Valid.validateEmail,
                decoration: const InputDecoration(labelText: email, prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            SizedBox(height: Sizes.m,),

            // Submit Button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.sendPasswordRestEmail(), child: const Text(submit))),
          ],
        ),
      ),
    );
  }
}
