import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/features/personalization/screens/settings/settings.dart';
import 'package:pet/features/shop/MyShop_Screen.dart';

import 'home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(0.5), // Border color with some transparency
                width: 1.0, // Border width
              ),
            ),
          ),
          child: NavigationBar(
            backgroundColor: Colors.white,
            indicatorColor: logoPurple,
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'Shop'),
              NavigationDestination(icon: Icon(Iconsax.book), label: 'Blog'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const Home(), MyShopScreen(), Container(color: Colors.purple,), const SettingScreen()];
}
