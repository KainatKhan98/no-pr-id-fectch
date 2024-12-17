import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/features/authentication/controllers/signup_controller.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text.dart';


class TermsAndConditionsCheckBox extends StatelessWidget {
  const TermsAndConditionsCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignUpController.instance;
    return Row(
      children: [
        SizedBox(width: 24, height: 24, child: Obx(() => Checkbox(
            value: controller.privacyPolicy.value,
            onChanged: (value) =>  controller.privacyPolicy.value = !controller.privacyPolicy.value)
          )
        ),
        SizedBox(width: Sizes.s,),
        Text.rich(
            TextSpan(
                children: [
                  TextSpan(text: agree, style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: policy,style: Theme.of(context).textTheme.bodySmall!.apply(decoration: TextDecoration.underline)),
                  TextSpan(text: and, style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: terms, style: Theme.of(context).textTheme.bodySmall!.apply(decoration: TextDecoration.underline)),
                ]
            )
        ),
      ],
    );
  }
}