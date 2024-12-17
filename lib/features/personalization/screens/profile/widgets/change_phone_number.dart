import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/constants/text.dart';
import 'package:pet/utils/validators/validation.dart';
import '../../../controller/change_phone_number_controller.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneController());
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change Phone Number', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Please enter the valid Phone Number',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: Sizes.s*2,),

            // Text Fields
            Form(
              key: controller.updatePhoneFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.phone,
                    validator: (value) => Valid.validatePhoneNumber(value),
                    style: const TextStyle(fontSize: 14),
                    expands: false,
                    decoration: const InputDecoration(labelText: phone, prefixIcon: Icon(Iconsax.call)),
                  ),
                ],
              ),
            ),
            SizedBox(height: Sizes.m,),

            // Save Button
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: () =>  controller.updatePhone(), child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
