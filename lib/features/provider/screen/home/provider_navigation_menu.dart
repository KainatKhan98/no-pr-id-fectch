import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/features/provider/screen/shop/MyShopScreen.dart';

import '../settings/settings.dart';
import 'home_screen.dart';


class ProviderNavigationMenu extends StatelessWidget {
  const ProviderNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: logoPurple,
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Dashboard'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'My Shop'),
            NavigationDestination(icon: Icon(Iconsax.book), label: 'My Blogs'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const ProviderHomeScreen(), MyShopScreen(), Container(color: Colors.purple,), const ProviderSettingScreen()];
}

