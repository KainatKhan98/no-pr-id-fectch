import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/features/authentication/controllers/signup_controller.dart';
import 'package:pet/features/authentication/screens/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:pet/utils/validators/validation.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [

              // First Name
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => Valid.validateEmpty('First name', value),
                  expands: false,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(labelText: firstName, prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              SizedBox(width: Sizes.s),

              // Last Name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => Valid.validateEmpty('Last name', value),
                  expands: false,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(labelText: lastName, prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          SizedBox(height: Sizes.s,),

          // Username
          TextFormField(
            controller: controller.userName,
            validator: (value) => Valid.validateUsername(value),
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(labelText: username, prefixIcon: Icon(Iconsax.user_edit)),
          ),
          SizedBox(height: Sizes.s,),

          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => Valid.validateEmail(value),
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(labelText: email, prefixIcon: Icon(CupertinoIcons.mail)),
          ),
          SizedBox(height: Sizes.s,),

          // Phone Number
          TextFormField(
            controller: controller.phoneNo,
            validator: (value) => Valid.validatePhoneNumber(value),
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(labelText: phone, prefixIcon: Icon(Iconsax.call)),
          ),
          SizedBox(height: Sizes.s,),

          // Password
          Obx(
            () => TextFormField(
              controller: controller.password,
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
          SizedBox(height: Sizes.s,),

          // Terms and Conditions
          const TermsAndConditionsCheckBox(),
          SizedBox(height: Sizes.m,),

          // SignUp Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(createAccount)
            ),
          ),
          SizedBox(height: Sizes.m,),
        ],
      ),
    );
  }
}
