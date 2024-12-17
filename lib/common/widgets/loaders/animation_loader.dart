import 'package:flutter/material.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/utils/helpers/helpers.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({super.key, required this.text, required this.image, this.showAction = false, this.actionText, this.onActionPressed});

  final String text;
  final String image;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(loader, width: HelpFunctions.screenWidth()*0.3),
          SizedBox(height: Sizes.xl),
          Text(text, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
          SizedBox(height: Sizes.defaultPadding),
          showAction ? SizedBox(
            width: 250,
            child: OutlinedButton(
                onPressed: onActionPressed,
                child: Text(actionText!, style: Theme.of(context).textTheme.bodyLarge,)
            ),
          )
          : const SizedBox(),
        ],
      ),
    );
  }
}
