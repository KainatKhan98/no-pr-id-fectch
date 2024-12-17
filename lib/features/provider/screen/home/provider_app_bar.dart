import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../personalization/controller/user_controller.dart';


class ProviderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProviderAppBar ({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return AppBar(
      toolbarHeight: 70,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(20),
      //   ),
      // ),
      backgroundColor: logoPurple,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(left: Sizes.s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Dashboard", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),),
                  ],
                ),
                // Obx(() {
                //   if(controller.profileLoading.value) {
                //     return const ShimmerEffect(width: 80, height: 15);
                //   }
                //   return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall);
                // }),

              ],
            ),
            Row(
              children: [
                Stack(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Iconsax.message), color: Colors.white,),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: logoPink,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text('2', style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification), color: Colors.white,),
                    Positioned(
                      right: 5,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: logoPink,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text('2', style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

