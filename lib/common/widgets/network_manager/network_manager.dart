// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:pet/common/widgets/loaders/loaders.dart';
//
// class NetworkManager extends GetxController {
//   static NetworkManager get instance => Get.find();
//
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(ConnectivityResult result) {
//       _connectionStatus.value = result;
//       if (_connectionStatus.value == ConnectivityResult.none) {
//         Loaders.warningSnackBar(title: 'No Internet Connection');
//       }
//     };
//   }
//
//   // Update the connection status based on changes in connectivity
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//
//   }
//
//   // Check the internet connection status.
//   // return true if connected otherwise false
//   Future<bool> isConnected() async {
//     try {
//       final result = await _connectivity.checkConnectivity();
//       if(result == ConnectivityResult.none) {
//         return false;
//       } else {
//         return true;
//       }
//     } on PlatformException catch (_) {
//       return false;
//     }
//   }
//
//   // Dispose or close the active connectivity stream
//   @override
//   void onClose() {
//     super.onClose();
//     _connectivitySubscription.cancel();
//   }
// }