import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/features/provider/model/provider_model.dart';
import 'package:pet/utils/popups/full_screen_loader.dart';
import '../model/service_model.dart';

class ProviderController extends GetxController {
  var providerBio = ''.obs;
  var isEditing = false.obs;
  Rx<ServiceProviderModel> user = ServiceProviderModel
      .empty()
      .obs;
  var services = <ServiceModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  void loadBio(String bio) {
    providerBio.value = bio;
  }

  Future<void> loadBioFromFirebase(String providerId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('providers')
          .doc(providerId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data['bio'] != null) {
          providerBio.value = data['bio'];
        }
      }
    } catch (e) {
      print('Error fetching bio: $e');
    }
  }

  Future<void> saveBio(String bio, String providerId) async {
    try {
      FullScreenLoader.openLoadingDialogue("Updating Bio...", loader);
      await FirebaseFirestore.instance.collection('providers')
          .doc(providerId)
          .set({
        'bio': bio,
      }, SetOptions(merge: true));

      providerBio.value = bio; // Update the local bio state
      user.value.bio = bio; // Update the bio in the provider model
      FullScreenLoader.stopLoading();
    } catch (e) {
      print('Error saving bio: $e');
      FullScreenLoader.stopLoading();
    }
  }

  Future<void> loadProviderFromFirebase(String providerId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('providers')
          .doc(providerId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          user.value = ServiceProviderModel.fromJson(data); // Load provider data into the controller
          providerBio.value = user.value.bio; // Load bio data
        }
      }
    } catch (e) {
      print('Error fetching provider data: $e');
    }
  }


}
