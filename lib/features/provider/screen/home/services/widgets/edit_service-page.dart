// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pet/constants/colors.dart';
// import 'package:pet/constants/sizes.dart';
// import '../../../controller/pdf_controller.dart';
// import '../../../controller/provider_controller.dart';
// import '../../../model/service_model.dart';
//
// class EditServicePage extends StatelessWidget {
//   final ServiceModel service;
//   final ProviderController controller = Get.find<ProviderController>(); // Use existing instance
//   final PdfController pdfController = Get.put(PdfController());
//
//   EditServicePage({super.key, required this.service}) {
//     controller.initializeWithService(service); // Initialize fields with existing data
//     pdfController.uploadUrl.value = service.certificateUrl ?? ''; // Preload the certificate URL if available
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Service'),
//         backgroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: controller.formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: controller.nameController,
//                 decoration: const InputDecoration(labelText: 'Service Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the service name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: Sizes.s),
//
//               TextFormField(
//                 controller: controller.descriptionController,
//                 decoration: const InputDecoration(labelText: 'Service Description'),
//                 maxLines: 3,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: Sizes.s),
//
//               TextFormField(
//                 controller: controller.priceController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: 'Price (Rs.)'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the service price';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: Sizes.s),
//
//               TextFormField(
//                 controller: controller.durationController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: 'Duration (minutes)'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the service duration';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: Sizes.s),
//
//               Obx(() => SwitchListTile(
//                 title: const Text('Service Available'),
//                 value: controller.isAvailable.value,
//                 onChanged: (value) {
//                   controller.isAvailable.value = value;
//                 },
//               )),
//               const SizedBox(height: 20),
//
//               // Show the existing certificate in a container with a cross to remove
//               Obx(() {
//                 return Column(
//                   children: [
//                     if (pdfController.uploadUrl.value.isNotEmpty) ...[
//                       // Show the current certificate in a container
//                       Stack(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               // You can open the PDF or perform an action here
//                               Get.snackbar("Certificate", "This is your current certificate.");
//                             },
//                             child: Container(
//                               width: 300,
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(color: Colors.grey, width: 2),
//                                 color: Colors.grey[100],
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.picture_as_pdf,
//                                     size: 50,
//                                     color: logoPurple,
//                                   ),
//                                   SizedBox(height: 10),
//                                   Text(
//                                     'Current Certificate',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 8,
//                             right: 8,
//                             child: GestureDetector(
//                               onTap: () {
//                                 // Clear the current certificate
//                                 pdfController.uploadUrl.value = '';
//                                 pdfController.fileName.value = '';
//                                 pdfController.file = null;
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(4.0),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.red,
//                                 ),
//                                 child: const Icon(
//                                   Icons.close,
//                                   color: Colors.white,
//                                   size: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                     ],
//                     // Allow user to upload a new certificate if desired
//                     GestureDetector(
//                       onTap: () async {
//                         await pdfController.pickPdfFile();
//                       },
//                       child: Container(
//                         width: 300,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey, width: 2),
//                           color: Colors.grey[100],
//                         ),
//                         child: Obx(() => Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.picture_as_pdf,
//                               size: 50,
//                               color: logoPurple,
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               pdfController.fileName.value.isEmpty
//                                   ? 'Tap to upload PDF'
//                                   : pdfController.fileName.value,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: pdfController.fileName.value.isEmpty
//                                     ? Colors.grey
//                                     : Colors.black,
//                                 fontWeight: pdfController.fileName.value.isEmpty
//                                     ? FontWeight.normal
//                                     : FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         )),
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//
//               const SizedBox(height: 20),
//
//               ElevatedButton(
//                 onPressed: () async {
//                   if (controller.formKey.currentState!.validate()) {
//                     String? certificateUrl;
//
//                     // If a new certificate is uploaded, get its URL
//                     if (pdfController.fileName.value.isNotEmpty) {
//                       certificateUrl = await pdfController.uploadCertificateToFirebase(
//                         context,
//                         pdfController.file!.path!,
//                         pdfController.fileName.value,
//                       );
//                     } else {
//                       certificateUrl = pdfController.uploadUrl.value; // Keep the existing one
//                     }
//
//                     // Proceed to update service with the updated certificate URL (if available)
//                     controller.updateService(
//                       service.serviceId,
//                       providerId: FirebaseAuth.instance.currentUser!.uid,
//                       certificateUrl: certificateUrl,
//                     );
//                   }
//                 },
//                 child: const Text('Update Service'),
//               ),
//               SizedBox(height: Sizes.s * 1.5),
//
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                 ),
//                 onPressed: () {
//                   if (controller.formKey.currentState!.validate()) {
//                     controller.deleteService(
//                         context, service.serviceId, FirebaseAuth.instance.currentUser!.uid);
//                   }
//                 },
//                 child: const Text('Delete Service'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/constants/sizes.dart';
import '../../../../controller/pdf_controller.dart';
import '../../../../controller/service_controller.dart';
import '../../../../model/service_model.dart';

class EditServicePage extends StatelessWidget {
  final ServiceModel service;
  final ServiceController controller = Get.find<ServiceController>(); // Use existing instance
  final PdfController pdfController = Get.put(PdfController());

  EditServicePage({super.key, required this.service}) {
    controller.initializeWithService(service); // Initialize fields with existing data
    pdfController.uploadUrl.value = service.certificateUrl ?? ''; // Preload the certificate URL if available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Service'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              SizedBox(height: Sizes.s),
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Service Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the service name';
                  }
                  return null;
                },
              ),
              SizedBox(height: Sizes.s),

              TextFormField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(labelText: 'Service Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: Sizes.s),

              TextFormField(
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price (Rs.)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the service price';
                  }
                  return null;
                },
              ),
              SizedBox(height: Sizes.s),

              TextFormField(
                controller: controller.durationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Duration (minutes)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the service duration';
                  }
                  return null;
                },
              ),
              SizedBox(height: Sizes.s),

              Obx(() => SwitchListTile(
                title: const Text('Service Available'),
                value: controller.isAvailable.value,
                onChanged: (value) {
                  controller.isAvailable.value = value;
                },
              )),
              const SizedBox(height: 20),

              // Show the existing certificate in a container with a cross to remove
              Obx(() {
                return Column(
                  children: [
                    if (pdfController.uploadUrl.value.isNotEmpty) ...[
                      // Show the current certificate in a container
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // You can open the PDF or perform an action here
                              Get.snackbar("Certificate", "This is your current certificate.");
                            },
                            child: Container(
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey, width: 2),
                                color: Colors.grey[100],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.picture_as_pdf,
                                    size: 50,
                                    color: logoPurple,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Current Certificate',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                // Clear the current certificate
                                pdfController.uploadUrl.value = '';
                                pdfController.fileName.value = '';
                                pdfController.file = null;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                    // Show the upload option only when there is no certificate
                    if (pdfController.uploadUrl.value.isEmpty) ...[
                      GestureDetector(
                        onTap: () async {
                          await pdfController.pickPdfFile();
                        },
                        child: Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 2),
                            color: Colors.grey[100],
                          ),
                          child: Obx(() => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.picture_as_pdf,
                                size: 50,
                                color: logoPurple,
                              ),
                              SizedBox(height: 10),
                              Text(
                                pdfController.fileName.value.isEmpty
                                    ? 'Tap to upload PDF'
                                    : pdfController.fileName.value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: pdfController.fileName.value.isEmpty
                                      ? Colors.grey
                                      : Colors.black,
                                  fontWeight: pdfController.fileName.value.isEmpty
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ],
                  ],
                );
              }),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    String? certificateUrl;

                    // If a new certificate is uploaded, get its URL
                    if (pdfController.fileName.value.isNotEmpty) {
                      certificateUrl = await pdfController.uploadCertificateToFirebase(
                        context,
                        pdfController.file!.path!,
                        pdfController.fileName.value,
                      );
                    } else {
                      certificateUrl = pdfController.uploadUrl.value; // Keep the existing one
                    }

                    // Proceed to update service with the updated certificate URL (if available)
                    controller.updateService(
                      service.serviceId,
                      providerId: FirebaseAuth.instance.currentUser!.uid,
                      certificateUrl: certificateUrl,
                    );
                  }
                },
                child: const Text('Update Service'),
              ),
              SizedBox(height: Sizes.s * 1.5),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.deleteService(
                        context, service.serviceId, FirebaseAuth.instance.currentUser!.uid);
                  }
                },
                child: const Text('Delete Service'),
              ),
              SizedBox(height: Sizes.s,)
            ],
          ),
        ),
      ),
    );
  }
}

