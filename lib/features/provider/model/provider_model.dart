// // provider_model.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ServiceProviderModel {
//   String id;
//   String bio;
//   DateTime createdAt;
//
//   ServiceProviderModel({required this.id, required this.bio, required this.createdAt});
//
//   static ServiceProviderModel empty() => ServiceProviderModel(id: '', bio: '', createdAt: DateTime.now());
//
//   // Convert a ProviderModel into a Map. The Map is used to send data to Firestore
//   Map<String, dynamic> toJson() {
//     return {
//       'bio': bio,
//       'createdAt': createdAt,
//     };
//   }
//
//   // Convert a Map into a ProviderModel
//   factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
//     return ServiceProviderModel(
//       id: json['ID'] ?? '',
//       bio: json['Bio'] ?? '',
//       createdAt: (json['createdAt'] as Timestamp).toDate(),
//     );
//   }
// }
//

import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderModel {
  String id;
  String firstName;
  String lastName;
  String username;
  String bio;
 // DateTime createdAt;
  String phoneNo;
  String profilePicture;

  // Constructor with the new fields
  ServiceProviderModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.bio,
  //  required this.createdAt,
    required this.phoneNo,
    required this.profilePicture,
  });

  static ServiceProviderModel empty() => ServiceProviderModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    bio: '',
   // createdAt: DateTime.now(),
    phoneNo: '',
    profilePicture: '',
  );

  // Convert a ServiceProviderModel into a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Bio': bio,
     // 'createdAt': createdAt,
      'PhoneNo': phoneNo,
      'ProfilePicture': profilePicture,
    };
  }

  // Convert a Map from Firestore to a ServiceProviderModel
  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json['ID'] ?? '',
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      username: json['Username'] ?? '',
      bio: json['Bio'] ?? '',
     // createdAt: (json['createdAt'] as Timestamp).toDate(),
      phoneNo: json['PhoneNo'] ?? '',
      profilePicture: json['ProfilePicture'] ?? '',
    );
  }
}

