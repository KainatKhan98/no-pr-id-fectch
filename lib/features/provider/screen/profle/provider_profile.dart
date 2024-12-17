import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/constants/sizes.dart';

import '../../../../common/widgets/circular_image/circular_image.dart';
import '../../../../common/widgets/shimmer/shimmer_effect.dart';
import '../../../../constants/images.dart';
import '../../../personalization/controller/user_controller.dart';


class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Container(
      padding: EdgeInsets.all(Sizes.defaultPadding),
      child: Row(
        children: [
          Obx((){
            final networkImage = controller.user.value.profilePicture;
            final image = networkImage.isNotEmpty ? networkImage : avatar;
            return controller.imageUploading.value
                ? const ShimmerEffect(width: 100, height: 100, radius: 80,)
                : CircularImage(image: image, width: 100, height: 100, isNetworkImage: networkImage.isNotEmpty, padding: 0,);
          }),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text("35 Rating 1 Review", style: TextStyle(color: Colors.grey, fontSize: 15)),
                ],
              ),
              const SizedBox(height: 8),
              const Text("Rawalpindi", style: TextStyle(color: Colors.grey, fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }
}
