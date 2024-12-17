import 'package:flutter/material.dart';
import '../../../../../constants/images.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {// Retrieve saved role
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          width: 100,
          height: 100,
          image: AssetImage(logo),
        ),
        SizedBox(height: Sizes.m),
        Text(loginTitle, style: Theme.of(context).textTheme.headlineLarge,),
      ],
    );
  }
}