import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/constants/text.dart';
import 'package:pet/utils/validators/validation.dart';
import '../../../controller/change_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Use real name for easy verification. This name will appear on several pages.',
            style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: Sizes.s*2,),

            // Text Fields
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    style: const TextStyle(fontSize: 14),
                    validator: (value) => Valid.validateEmpty('First Name', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: firstName, prefixIcon: Icon(Iconsax.user)),
                  ),
                  SizedBox(height: Sizes.s,),
                  TextFormField(
                    controller: controller.lastName,
                    style: const TextStyle(fontSize: 14),
                    validator: (value) => Valid.validateEmpty('Last Name', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: lastName, prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              ),
            ),
            SizedBox(height: Sizes.m,),

            // Save Button
            SizedBox(width: double.infinity,
            child: ElevatedButton(onPressed: () =>  controller.updateUserName(), child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
