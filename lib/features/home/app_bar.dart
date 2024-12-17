import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../common/widgets/shimmer/shimmer_effect.dart';
import '../personalization/controller/user_controller.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
const MyAppBar ({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(left: Sizes.s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('Hello!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: text2)),
                  ],
                ),
                Obx(() {
                  if(controller.profileLoading.value) {
                    return const ShimmerEffect(width: 80, height: 15);
                  }
                  return Text(controller.user.value.fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: text2));
                }),

              ],
            ),
            Row(
              children: [
                Stack(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Iconsax.message), color: text2,),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: logoPink,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text('2', style: TextStyle(fontSize: 12, color: text2)),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification), color: text2,),
                    Positioned(
                      right: 5,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: logoPink,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text('2', style: TextStyle(fontSize: 12, color: text2)),
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

