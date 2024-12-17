
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/user_repository.dart';
import '../model/pet_model.dart';

class PetController extends GetxController {
  static PetController get instance => Get.find();

  var pet = Pet.empty().obs;
  var pets = <Pet>[].obs;
  var isLoadingImage = false.obs;
  final imageUploading = false.obs;
  final userRepository = Get.put(UserRepository());

  String? getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid; // Returns the user ID or null if not logged in
  }

  void addPet(String userId, Pet pet) async {
    String petId = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('pets')
        .doc()
        .id;
    pet.id = petId;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('pets')
        .doc(petId)
        .set(pet.toMap());

    fetchPets(userId); // Refresh the pet list after adding
  }

  void fetchPets(String userId) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('pets')
        .snapshots()
        .listen((snapshot) {
      print("Fetched pets count: ${snapshot.docs.length}"); // Debug line
      pets.value = snapshot.docs.map((doc) => Pet.fromMap(doc.data())).toList();
    });
  }

  Future<void> updatePet(String petId, Pet pet) async {
    String? userId = getCurrentUserId();

    if (userId == null) {
      print("No user is logged in.");
      return;
    }

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('pets')
        .doc(petId)
        .update(pet.toMap());

    int index = pets.indexWhere((p) => p.id == petId);
    if (index != -1) {
      pets[index] = pet;
    }
  }

  uploadProfilePicture(String petId) async {
    try {
      print('petId: $petId');
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if(image != null) {
        imageUploading.value = true;

        // Uploading Image
        final imageUrl = await userRepository.uploadImage('Pets/Profile', image);

        // Update User Image Record
        String? userId = getCurrentUserId();
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('pets')
              .doc(petId)  // Assuming pet has an id value
              .update({'imageUrl': imageUrl});  // Save the image URL to Firestore
        }
        pet.refresh();

        Loaders.successSnackBar(title: "Congratulations", message: 'Your Profile Image has been updated');
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }

  // void deletePet(String petId) async {
  //   String? userId = getCurrentUserId();
  //
  //   if (userId == null) {
  //     print("No user is logged in.");
  //     return;
  //   }
  //
  //   try {
  //     // Delete the pet document from Firestore
  //     await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(userId)
  //         .collection('pets')
  //         .doc(petId)
  //         .delete();
  //
  //     // Remove the pet from the local list
  //     pets.removeWhere((pet) => pet.id == petId);
  //
  //     Loaders.successSnackBar(title: 'Success!', message: 'Your pet has been removed');
  //
  //     Get.back();
  //   } catch (e) {
  //     Loaders.errorSnackBar(title:'Error', message: 'Your pet has not been removed');
  //   }
  // }

  void deletePet(String petId) async {

    String? userId = getCurrentUserId();

    if (userId == null) {
      print("No user is logged in.");
      return;
    }

    try {
      // Delete the pet document from Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('pets')
          .doc(petId)
          .delete();

      // Remove the pet from the local list
      pets.removeWhere((pet) => pet.id == petId);

      // Show success message using ScaffoldMessenger
      Loaders.successSnackBar(title:"Success", message: "Your pet has been removed");

      Get.back();
    } catch (e) {
      // Show error message using ScaffoldMessenger
      Loaders.errorSnackBar(title: "Error", message: "Your pet has not been removed");
    }
  }



}