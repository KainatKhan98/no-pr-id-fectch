import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/features/pets/controller/pet_controller.dart';
import '../../../../common/widgets/circular_image/circular_image.dart';
import '../../../../common/widgets/shimmer/shimmer_effect.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/images.dart';
import '../../../../constants/sizes.dart';
import '../../model/pet_model.dart';
import '../pet_screen/widgets/edit_pet.dart';

class PetProfile extends StatelessWidget {
  final Pet pet;
  var pets = <Pet>[].obs;

  PetProfile({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final controller = PetController.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pet.name,
          style: const TextStyle(color: textColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.edit, color: textColor), // Change icon to any desired icon
              onPressed: () {
                // Action when icon is pressed
                Get.to(() => EditPetScreen(pet: pet));
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pet Image
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                      final networkImage = pet.imageUrl;
                      final image = networkImage.isNotEmpty ? networkImage : cat;
                      return controller.imageUploading.value
                          ? const ShimmerEffect(width: 100, height: 100, radius: 80,)
                          : CircularImage(image: image, width: 100, height: 100, isNetworkImage: networkImage.isNotEmpty,);
                    }),
                    TextButton(onPressed: () => controller.uploadProfilePicture(pet.id), child: Text('Change Profile Picture', style: Theme.of(context).textTheme.bodySmall,)),
                  ],
                ),
              ),
              SizedBox(height: Sizes.defaultPadding),
              const Divider(),

              // Full Description Section (Moved above other details)
              Container(
                padding: EdgeInsets.all(Sizes.defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About ${pet.name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Sizes.defaultPadding / 2),
                    Text(
                      pet.description.isNotEmpty
                          ? pet.description
                          : 'No additional description provided.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(),

              // Pet Info Section (Below the description)
              Container(
                padding: EdgeInsets.all(Sizes.defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPetInfoRow('Type', pet.type),
                    _buildPetInfoRow('Breed', pet.breed),
                    _buildPetInfoRow('Age', '${pet.age} months'),
                    _buildPetInfoRow('Weight', '${pet.weight} kg'),
                    _buildPetInfoRow('Sex', pet.sex),
                    _buildPetInfoRow('Diseases', pet.medicalRecord.diseases.isNotEmpty
                        ? pet.medicalRecord.diseases.join(', ')
                        : 'None'),
                    _buildPetInfoRow('Vaccinations', pet.medicalRecord.vaccinations.isNotEmpty
                        ? pet.medicalRecord.vaccinations.join(', ')
                        : 'None'),
                  ],
                ),
              ),

              SizedBox(height: Sizes.defaultPadding),

              // Edit Profile Button
              Center(
                child: ElevatedButton(
                  onPressed: () => Get.to(() => EditPetScreen(pet: pet)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: logoPurple, // Change this to your desired button color
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Edit Profile'),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: TextButton(
                  child: const Text('Remove Pet',  style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    // Show a confirmation dialog before deletion
                    Get.defaultDialog(
                      backgroundColor: Colors.white,
                      contentPadding: EdgeInsets.all(Sizes.s*2),
                      title: "Remove Pet",
                      content: Text("Are you sure you want to remove this pet permanently?", textAlign: TextAlign.center,),
                      confirm: ElevatedButton(
                        onPressed: () {
                          controller.deletePet(pet.id);
                          Get.back(); // Close the dialog after deletion
                        },
                        child: Text("Yes"),
                      ),
                      cancel: TextButton(
                        onPressed: () {
                          Get.back(); // Close the dialog without deleting
                        },
                        child: Text("No"),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPetInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.defaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
