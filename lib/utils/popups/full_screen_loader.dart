import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/loaders/animation_loader.dart';

class FullScreenLoader {
  static void openLoadingDialogue(String text, String image) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(width: 250,),
                const SizedBox(height: 220,),
                AnimationLoaderWidget(text: text, image: image),
              ],
            ),
          ),
        )
    );
  }
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

