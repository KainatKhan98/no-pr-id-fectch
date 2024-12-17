import 'package:flutter/material.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/constants/text.dart';
import 'package:pet/features/authentication/screens/login/widgets/login_form.dart';
import 'package:pet/features/authentication/screens/login/widgets/login_header.dart';
import '../../../../common/widgets/login_and_signup/form_divider.dart';
import '../../../../common/widgets/login_and_signup/social_buttons.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Sizes.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // logo and Text
                const LoginHeader(),

                // Form
                const LoginForm(),

                // Divider
                const FormDivider(dividerText: signinwith,),
                SizedBox(height: Sizes.m,),

                // Footer
                const SocialButtons(),
              ],
            )
          ),
        ),
      ),
    );
  }
}