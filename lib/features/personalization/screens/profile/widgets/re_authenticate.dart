import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/utils/validators/validation.dart';
import '../../../../../constants/text.dart';
import '../../../controller/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultPadding),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: Valid.validateEmail,
                  decoration: const InputDecoration(labelText: email, prefixIcon: Icon(CupertinoIcons.mail)),
                ),
                SizedBox(height: Sizes.s,),

                // Password
                Obx(() => TextFormField(
                    controller: controller.verifyPassword,
                    validator: (value) => Valid.validatePassword(value),
                    obscureText: controller.hidePassword.value,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        labelText: password,
                        prefixIcon: const Icon(Iconsax.lock),
                        suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                        )
                    ),
                  ),
                ),
                SizedBox(height: Sizes.m,),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => controller.reAuthenticationEmailAndPasswordUser(), child: const Text('Verify')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
