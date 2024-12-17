import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/features/pets/screen/pet_screen/widgets/add_pet_button.dart';
import 'package:pet/features/pets/screen/profile/pet_profile.dart';
import '../../../../common/widgets/circular_image/circular_image.dart';
import '../../../../common/widgets/shimmer/shimmer_effect.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/images.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../controller/pet_controller.dart';

class MyPetsScreen extends StatelessWidget {
  final String userId;
  final PetController petController = Get.put(PetController());

  MyPetsScreen({super.key, required this.userId}) {
    petController.fetchPets(userId); // Fetch pets when the screen is created
  }


  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: textColor,
        title: const Text(
          'My Pets',
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (petController.isLoadingImage.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (petController.pets.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(Sizes.defaultPadding),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "You currently have no pets.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: Sizes.defaultPadding),
                SizedBox(
                  width: 150,
                  child: AddPetButton(userController: userController),
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: petController.pets.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => PetProfile(pet: petController.pets[index]));
                      },
                      child: ListTile(
                        leading: Obx((){
                          final networkImage = petController.pets[index].imageUrl;
                          final image = networkImage.isNotEmpty ? networkImage : cat;
                          return petController.imageUploading.value
                              ? const ShimmerEffect(width: 100, height: 100, radius: 80,)
                              : CircularImage(image: image, width: 100, height: 100, isNetworkImage: networkImage.isNotEmpty, fit: BoxFit.fill,);
                        }),
                        title: Text(petController.pets[index].name, style: TextStyle(color: textColor),),
                        subtitle: Text(
                          '${petController.pets[index].type}, ${petController.pets[index].breed}, Age: ${petController.pets[index].age}', style: TextStyle(color: textColor)
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (petController.pets.length < 5)
                Padding(
                  padding: EdgeInsets.all(Sizes.defaultPadding),
                  child: SizedBox(
                    width: 150,
                    child: AddPetButton(userController: userController),
                  ),
                ),
            ],
          );
        }
      }),
    );
  }
}
