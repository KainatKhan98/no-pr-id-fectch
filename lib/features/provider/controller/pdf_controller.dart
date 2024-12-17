import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PdfController extends GetxController {
  var fileName = ''.obs; // Observable for file name
  PlatformFile? file; // To store file details
  var isUploading = false.obs; // To track upload progress
  var uploadUrl = ''.obs; // To store the uploaded file URL

  // Function to pick a PDF file and upload it
  Future<void> pickPdfFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      if (result != null && result.files.isNotEmpty) {
        file = result.files.first;
        fileName.value = file!.name;

        // Call the upload function
        if (file!.path != null) {
          isUploading.value = true;
          String? url = await uploadCertificateToFirebase(
              Get.context!, file!.path!, file!.name);
          isUploading.value = false;

          if (url != null) {
            uploadUrl.value = url;
            Get.snackbar("Success", "File uploaded successfully!");
          } else {

          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick file: $e');
    }
  }

  // Function to upload the selected file to Firebase
  Future<String?> uploadCertificateToFirebase(
      BuildContext context, String filePath, String filename) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('Users/images/Profile/certificates/$fileName');

      // Upload the file
      UploadTask uploadTask = ref.putFile(File(filePath));
      TaskSnapshot snapshot = await uploadTask;

      // Get the file URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar("Error", "Failed to upload certificate: $e");
      return null;
    }
  }


}