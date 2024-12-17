import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/features/authentication/controllers/login_controller.dart';
import '../../../../../constants/images.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //
    //     /// Google
    //     Container(
    //       decoration: BoxDecoration(border: Border.all(color: logoPurple), borderRadius: BorderRadius.circular(100)),
    //       child: IconButton(
    //           onPressed: () => controller.googleSignIn(),
    //           icon: const Image(
    //             width: 30,
    //             height: 30,
    //             image: AssetImage(google),
    //           )
    //       ),
    //     ),
    //     SizedBox(width: Sizes.m/2,),
    //
    //     /// Facebook
    //     Container(
    //       decoration: BoxDecoration(border: Border.all(color: logoPurple), borderRadius: BorderRadius.circular(100)),
    //       child: IconButton(
    //           onPressed: () {},
    //           icon: const Image(
    //             width: 30,
    //             height: 30,
    //             image: AssetImage(facebook),
    //           )
    //       ),
    //     )
    //   ],
    // );
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
          icon: const Image(image: AssetImage(google), width: 15,),
          onPressed: () => controller.googleSignIn(),
          label: const Text('Google')
      ),
    );
  }
}