import 'package:flutter/material.dart';
import 'package:pet/constants/text.dart';
import '../../../constants/sizes.dart';
import '../../../utils/helpers/helpers.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Sizes.defaultPadding),
            child: Column(
              children: [
                Image(image: AssetImage(image), width: HelpFunctions.screenWidth()*0.8,),
                SizedBox(height: Sizes.m),
          
                // Title and Subtitle
                Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
                SizedBox(height: Sizes.s),
                Text(subTitle, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,),
                SizedBox(height: Sizes.l),
          
                // Buttons
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: const Text(continu)),),
                SizedBox(height: Sizes.s),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
