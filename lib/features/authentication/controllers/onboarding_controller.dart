import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/welcome/welcome.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update current Index
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to dot
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Jump to next
  void nextPage() {
    if(currentPageIndex.value == 2){
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll(const WelcomeScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  // Jump to last
  void skipPage() {
    Get.to(const WelcomeScreen());
  }
}