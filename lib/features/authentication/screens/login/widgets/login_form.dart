import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/features/authentication/controllers/login_controller.dart';
import 'package:pet/features/authentication/screens/password/forgot_password.dart';
import 'package:pet/utils/validators/validation.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text.dart';
import '../../signup/signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form (
      key: controller.loginFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Sizes.m),
        child: Column (
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => Valid.validateEmail(value),
              cursorColor: textColor,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(prefixIcon: Icon(CupertinoIcons.mail), labelText: email),
            ),
            SizedBox(height: Sizes.s,),

            // Password
            Obx(
                  () => TextFormField(
                controller: controller.password,
                validator: (value) => Valid.validateEmpty('Password', value),
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

            // Remember Me and Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember Me
                Row(
                  children: [
                    Obx(
                            () => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.rememberMe.value =!controller.rememberMe.value)
                    ),
                    const Text(remember, style: TextStyle(color: textColor, fontSize: 14),),
                  ],
                ),

                // Forgot Password
                TextButton(onPressed: () => Get.to(const ForgotPassword()), child: const Text(forgot, style: TextStyle(fontSize: 14, color: logoPurple),)),
              ],
            ),
            SizedBox(height: Sizes.m/2,),

            // SignIn Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), child: const Text(signin))),
            SizedBox(height: Sizes.s,),

            // Create Your Account
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(const SignupScreen()), child: const Text(account))),
          ],
        ),
      ),
    );
  }
}