import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet/common/widgets/circular_image/circular_image.dart';
import 'package:pet/features/personalization/controller/user_controller.dart';

import '../../../../../common/widgets/shimmer/shimmer_effect.dart';
import '../../../../../constants/images.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      //leading: const CircularImage(image: avatar, padding: 0,),
      leading: Obx((){
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : avatar;
        return controller.imageUploading.value
            ? const ShimmerEffect(width: 100, height: 100, radius: 80,)
            : CircularImage(image: image, isNetworkImage: networkImage.isNotEmpty, padding: 0,);
      }),
      title: Text(controller.user.value.firstName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),),
      subtitle:Text(controller.user.value.email, style: const TextStyle(color: Colors.white, fontSize: 12)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit), color: Colors.white,),
    );
  }
}

// ClipRRect(
// borderRadius: BorderRadius.circular(50.0),
// child: Image.asset(welcomeImage,
// height: 50.0,
// width: 50.0,
// fit:BoxFit.cover,
// ),
// ),
