// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../features/provider/model/provider_model.dart';
//
//
// class ServiceProviderRepository {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//
//   // Save service provider record
//   Future<void> saveServiceProvider(ServiceProviderModel serviceProvider) async {
//     try {
//       await db.collection('ServiceProviders').doc(serviceProvider.id).set(serviceProvider.toJson());
//     } catch (e) {
//       throw 'Error saving service provider: $e';
//     }
//   }
//
//   // Fetch service provider data by ID
//   Future<ServiceProviderModel?> getServiceProvider(String providerId) async {
//     try {
//       DocumentSnapshot document = await db.collection('ServiceProviders').doc(providerId).get();
//       if (document.exists) {
//         return ServiceProviderModel.fromJson(document.data() as Map<String, dynamic>);
//       }
//       return null;
//     } catch (e) {
//       throw 'Error fetching service provider: $e';
//     }
//   }
// }
