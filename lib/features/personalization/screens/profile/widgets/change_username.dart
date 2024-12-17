import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/constants/text.dart';
import 'package:pet/utils/validators/validation.dart';
import '../../../controller/change_username_controller.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUsernameController());
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change Username', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Enter your username. This not show anywhere in the app',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: Sizes.s*2,),

            // Text Fields
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.username,
                    style: const TextStyle(fontSize: 14),
                    validator: (value) => Valid.validateUsername(value),
                    expands: false,
                    decoration: const InputDecoration(labelText: firstName, prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              ),
            ),
            SizedBox(height: Sizes.m,),

            // Save Button
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: () =>  controller.updateUserUsername(), child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
