import 'package:flutter/material.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/constants/text.dart';
import 'package:pet/features/authentication/screens/signup/widgets/signup_form.dart';
import '../../../../common/widgets/login_and_signup/form_divider.dart';
import '../../../../common/widgets/login_and_signup/social_buttons.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Title
              Text(signupTitle, style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: Sizes.m),

              //Form
              const SignupForm(),

              //Divider
              const FormDivider(dividerText: signupwith),
              SizedBox(height: Sizes.m,),

              //  Social Buttons
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
