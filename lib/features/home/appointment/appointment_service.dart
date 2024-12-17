
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pet/features/home/home.dart';
import 'package:pet/features/home/navigation_menu.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:pet/main.dart';

import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../payment/service.dart';
import '../../pets/controller/pet_controller.dart';
import '../../pets/model/pet_model.dart';

class AppointmentSelectionScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String name;
  final String description;
  final double price;
  final String providerId;

  AppointmentSelectionScreen({
    required this.userName,
    required this.userEmail,
    required this.name,
    required this.description,
    required this.price,
    required this.providerId,
  });

  @override
  _AppointmentSelectionScreenState createState() =>
      _AppointmentSelectionScreenState();
}

class _AppointmentSelectionScreenState
    extends State<AppointmentSelectionScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedSlot = '';
  String address = '';
  String? selectedPetId;
  Pet? selectedPet;
  String selectedPaymentMethod = '';
  List<String> timeSlots = [
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '4:30 PM',
    '5:00 PM'
  ];
  List<String> unavailableSlots = [];
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final PetController petController = Get.put(PetController());

  Future<void> fetchUnavailableSlots() async {
    if (selectedDate == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('providerId', isEqualTo: widget.providerId)
        .where('date', isEqualTo: selectedDate!.toIso8601String().split('T')[0])
        .get();

    setState(() {
      unavailableSlots =
          snapshot.docs.map((doc) => doc['slot'] as String).toList();
    });
  }

  void _selectTimeSlot(String slot) {
    setState(() {
      selectedSlot = slot;
    });
  }

  bool _isValidSelection() {
    return selectedSlot.isNotEmpty &&
        selectedDate != null &&
        address.isNotEmpty &&
        selectedPaymentMethod.isNotEmpty &&
        selectedPetId != null;
  }

  Future<void> _showInAppNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails('appointment_channel', 'Appointments',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: false);

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
  // Future<void> _bookAppointment() async {
  //   if (_isValidSelection()) {
  //     if (selectedPaymentMethod == "Credit/Debit Card") {
  //       try {
  //         // Await the payment process and check if it's successful
  //         bool paymentSuccess =
  //         await StripeService.instance.makePayment(widget.userEmail, widget.price);
  //
  //         if (paymentSuccess) {
  //           // Proceed with booking the appointment only if the payment was successful
  //           String currentUserEmail =
  //               FirebaseAuth.instance.currentUser?.email ?? 'No User';
  //
  //           await FirebaseFirestore.instance.collection('appointments').add({
  //             'providerName': widget.userName,
  //             'providerEmail': widget.userEmail,
  //             'serviceName': widget.name,
  //             'appointmentDate': selectedDate,
  //             'appointmentTime': selectedSlot,
  //             'userEmail': currentUserEmail,
  //             'address': address,
  //             'paymentMethod': selectedPaymentMethod,
  //             'petId': selectedPetId,
  //             'petName': selectedPet?.name,
  //           });
  //
  //           // Schedule a notification after successful booking
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Appointment booked successfully!')),
  //           );
  //           Get.to(NavigationMenu()); // Navigate to the navigation menu
  //         } else {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Payment failed, please try again.')),
  //           );
  //         }
  //       } catch (e) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Error during payment or booking: $e')),
  //         );
  //       }
  //     } else {
  //       // If payment method is COD, proceed with booking directly
  //       String currentUserEmail =
  //           FirebaseAuth.instance.currentUser?.email ?? 'No User';
  //
  //       try {
  //         await FirebaseFirestore.instance.collection('appointments').add({
  //           'providerName': widget.userName,
  //           'providerEmail': widget.userEmail,
  //           'serviceName': widget.name,
  //           'appointmentDate': selectedDate,
  //           'appointmentTime': selectedSlot,
  //           'userEmail': currentUserEmail,
  //           'address': address,
  //           'paymentMethod': selectedPaymentMethod,
  //           'petId': selectedPetId,
  //           'petName': selectedPet?.name,
  //         });
  //
  //         // Schedule a notification after successful booking
  //         await _showInAppNotification(
  //           'Appointment Confirmed',
  //           'Your appointment on ${selectedDate!.toLocal()} at $selectedSlot is confirmed.',
  //         );
  //
  //         // await _showInAppNotification(
  //         //   'New Appointment Booked',
  //         //   '${widget.userName} has booked an appointment for ${widget.name} on ${selectedDate!.toLocal()} at $selectedSlot.',
  //         // );
  //
  //         final reminderTime = selectedDate!.subtract(const Duration(days: 1));
  //
  //         scheduleReminder(
  //           'Upcoming Appointment',
  //           'You have an appointment scheduled tomorrow at $selectedSlot.',
  //           reminderTime,
  //         );
  //
  //         scheduleReminder(
  //           'Appointment Reminder',
  //           'You have an appointment with ${widget.userName} tomorrow at $selectedSlot.',
  //           reminderTime,
  //         );
  //
  //         _navigateToHome();
  //         Get.back();
  //       } catch (e) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Error during booking: $e')),
  //         );
  //       }
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please fill all required fields.')),
  //     );
  //   }
  // }

  Future<void> _bookAppointment() async {
    if (_isValidSelection()) {
      if (selectedPaymentMethod == "Credit/Debit Card") {
        try {
          // Await the payment process and check if it's successful
          bool paymentSuccess = await StripeService.instance
              .makePayment(widget.userEmail, widget.price);

          if (paymentSuccess) {
            await _saveAppointment();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Appointment booked successfully!')),
            );
            Get.to(NavigationMenu()); // Navigate to the navigation menu
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment failed, please try again.')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error during payment or booking: $e')),
          );
        }
      } else {
        // If payment method is COD, proceed with booking directly
        try {
          await _saveAppointment();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Appointment booked successfully!')),
          );
          Get.to(NavigationMenu()); // Navigate to the navigation menu
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error during booking: $e')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields.')),
      );
    }
  }

  Future<void> _saveAppointment() async {
    String currentUserEmail =
        FirebaseAuth.instance.currentUser?.email ?? 'No User';

    await FirebaseFirestore.instance.collection('appointments').add({
      'providerName': widget.userName,
      'providerEmail': widget.userEmail,
      'serviceName': widget.name,
      'appointmentDate': selectedDate,
      'appointmentTime': selectedSlot,
      'userEmail': currentUserEmail,
      'address': address,
      'paymentMethod': selectedPaymentMethod,
      'petId': selectedPetId,
      'petName': selectedPet?.name,
    });

    await _showInAppNotification(
      'Appointment Confirmed',
      'Your appointment on ${selectedDate!.toLocal()} at $selectedSlot is confirmed.',
    );

    // Save the notification for the provider
    await FirebaseFirestore.instance.collection('providerNotifications').add({
      'providerName': widget.name, // Provider's email
      'title': 'New Appointment Booked',
      'body':
      '$currentUserEmail has booked an appointment for ${widget.name} on ${selectedDate!.toLocal()} at $selectedSlot.',
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Schedule reminders for the user
    final reminderTime = selectedDate!.subtract(const Duration(days: 1));

    scheduleReminder(
      'Upcoming Appointment',
      'You have an appointment scheduled tomorrow at $selectedSlot.',
      reminderTime,
    );

    scheduleReminder(
      'Appointment Reminder',
      'You have an appointment with ${widget.userName} tomorrow at $selectedSlot.',
      reminderTime,
    );
  }

  void listenToProviderNotifications(String providerEmail) {
    FirebaseFirestore.instance
        .collection('providerNotifications')
        .where('providerEmail', isEqualTo: providerEmail)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      for (var doc in snapshot.docChanges) {
        if (doc.type == DocumentChangeType.added) {
          // Show a local notification
          _showLocalNotification(
            doc.doc['title'] ?? 'Notification',
            doc.doc['body'] ?? '',
          );
        }
      }
    });
  }

  void _showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'provider_channel', // Unique channel ID
      'Provider Notifications', // Channel name
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      notificationDetails,
    );
  }

  Future<void> scheduleReminder(
      String title, String body, DateTime scheduledDate) async {
    if (scheduledDate.isBefore(DateTime.now())) return;

    final tz.TZDateTime tzScheduledDate =
    tz.TZDateTime.from(scheduledDate, tz.local);

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tzScheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedSlot = '';
      });
      await fetchUnavailableSlots();
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Home()),
          (Route<dynamic> route) => false,
    );
    selectedPaymentMethod.isNotEmpty && selectedPetId != null;
  }

  @override
  void initState() {
    super.initState();
    String providerEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    listenToProviderNotifications(providerEmail);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Appointment',
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        foregroundColor: textColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Date:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: textColor,
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Time Slot Selection using GridView
              Text(
                "Select Time Slot:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 2.5,
                ),
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return ChoiceChip(
                    label: Text(timeSlots[index]),
                    selected: selectedSlot == timeSlots[index],
                    onSelected: (selected) {
                      _selectTimeSlot(timeSlots[index]);
                    },
                    backgroundColor: backgrndclrpurple,
                    selectedColor: Colors.purple[200],
                    labelStyle: TextStyle(color: Colors.black),
                  );
                },
              ),
              SizedBox(height: 20),

              // Select Pet Dropdown
              Text(
                "Select Pet:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Obx(() {
                // Fetch pets from the PetController
                var pets = petController.pets;

                if (pets.isEmpty) {
                  return Center(child: Text("No pets found"));
                }

                return DropdownButton<String>(
                  hint: Text("Select your pet"),
                  value: selectedPetId,
                  onChanged: (String? newPetId) {
                    setState(() {
                      selectedPetId = newPetId;
                      selectedPet =
                          pets.firstWhere((pet) => pet.id == newPetId);
                    });
                  },
                  items: pets.map<DropdownMenuItem<String>>((Pet pet) {
                    return DropdownMenuItem<String>(
                      value: pet.id,
                      child: Text(pet.name),
                    );
                  }).toList(),
                );
              }),
              SizedBox(height: 20),

              // Address Input Field
              Text(
                "Enter Address:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Payment Method Selection
              Text(
                "Select Payment Method:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  ListTile(
                    title: Text("Credit/Debit Card"),
                    leading: Radio<String>(
                      value: "Credit/Debit Card",
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Cash on Delivery (COD)"),
                    leading: Radio<String>(
                      value: "Cash on Delivery",
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Confirm Button
              Center(
                child: ElevatedButton(
                  onPressed: _bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgrndclrpurple,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("Confirm Booking"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






















// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:pet/features/home/home.dart';
// import 'package:pet/features/home/navigation_menu.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:pet/main.dart';
//
//
// import '../../../constants/colors.dart';
// import '../../../constants/constants.dart';
// import '../../payment/service.dart';
// import '../../pets/controller/pet_controller.dart';
// import '../../pets/model/pet_model.dart';
//
// class AppointmentSelectionScreen extends StatefulWidget {
//   final String userName;
//   final String userEmail;
//   final String name;
//   final String description;
//   final double price;
//   final String providerId;
//
//   AppointmentSelectionScreen({
//     required this.userName,
//     required this.userEmail,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.providerId,
//   });
//
//   @override
//   _AppointmentSelectionScreenState createState() =>
//       _AppointmentSelectionScreenState();
// }
//
// class _AppointmentSelectionScreenState
//     extends State<AppointmentSelectionScreen> {
//   // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   @override
//
//   DateTime selectedDate = DateTime.now();
//   String selectedSlot = '';
//   String address = '';
//   String? selectedPetId; // Store the selected pet's ID
//   Pet? selectedPet;
//   String selectedPaymentMethod = '';
//   List<String> timeSlots = [
//     '9:00 AM',
//     '9:30 AM',
//     '10:00 AM',
//     '10:30 AM',
//     '11:00 AM',
//     '11:30 AM',
//     '12:00 PM',
//     '12:30 PM',
//     '1:00 PM',
//     '1:30 PM',
//     '2:00 PM',
//     '2:30 PM',
//     '3:00 PM',
//     '3:30 PM',
//     '4:00 PM',
//     '4:30 PM',
//     '5:00 PM'
//   ];
//   List<String> unavailableSlots = [];
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   final PetController petController = Get.put(PetController());
//
//   // Fetch unavailable slots from Firestore
//   Future<void> fetchUnavailableSlots() async {
//     if (selectedDate == null) return;
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('appointments')
//         .where('providerId', isEqualTo: widget.providerId) // Filter by provider
//         .where('date', isEqualTo: selectedDate!.toIso8601String().split('T')[0])
//         .get();
//
//     setState(() {
//       unavailableSlots =
//           snapshot.docs.map((doc) => doc['slot'] as String).toList();
//     });
//   }
//
//   // Function to select the time slot
//   void _selectTimeSlot(String slot) {
//     setState(() {
//       selectedSlot = slot;
//     });
//   }
//
//   // Validate if all inputs are valid
//   bool _isValidSelection() {
//     return selectedSlot.isNotEmpty &&
//         selectedDate != null &&
//         address.isNotEmpty &&
//         selectedPaymentMethod.isNotEmpty &&
//         selectedPetId != null;
//   }
//
//   Future<void> _showInAppNotification(String title, String body) async {
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails('appointment_channel', 'Appointments',
//         importance: Importance.high,
//         priority: Priority.high,
//         showWhen: false);
//
//     const NotificationDetails notificationDetails =
//     NotificationDetails(android: androidDetails);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails,
//     );
//   }
//
// //   Future<void> _showInAppNotification(String title, String body) async {
// //     const AndroidNotificationDetails androidDetails =
// //         AndroidNotificationDetails(
// //       'appointment_channel_id', // Unique channel ID
// //       'Appointment Notifications', // Channel name
// //       importance: Importance.high,
// //       priority: Priority.high,
// //     );
// //
// //     const NotificationDetails platformDetails = NotificationDetails(
// //       android: androidDetails,
// //     );
// //
// //     await flutterLocalNotificationsPlugin.show(
// //       0, // Notification ID
// //       title, // Notification title
// //       body, // Notification body
// //       platformDetails,
// //     );
// //   }
// //
// //   Save appointment to Firestore and navigate to Home
// //   Future<void> saveAppointment() async {
// //     if (selectedDate == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Please select a date.')),
// //       );
// //       return;
// //     }
// //
// //     if (selectedSlot.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Please select a time slot.')),
// //       );
// //       return;
// //     }
// //
// //     if (address.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Please enter your address.')),
// //       );
// //       return;
// //     }
// //
// //     if (selectedPaymentMethod.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Please select a payment method.')),
// //       );
// //       return;
// //     }
// //
// //     try {
// //       // Retrieve the provider ID
// //       final QuerySnapshot providerSnapshot = await FirebaseFirestore.instance
// //           .collection('providers')
// //           .where('serviceName', isEqualTo: widget.name)
// //           .get();
// //
// //       if (providerSnapshot.docs.isEmpty) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Provider not found for this service.')),
// //         );
// //         return;
// //       }
// //
// //       final providerData =
// //           providerSnapshot.docs.first.data() as Map<String, dynamic>;
// //       final String providerId = providerData['providerId'];
// //        final String providerName = providerData['providerName']; // Optional: Retrieve provider name
// //
// //       // Save appointment to Firestore
// //       await FirebaseFirestore.instance.collection('appointments').add({
// //         'userName': widget.userName,
// //         'userEmail': widget.userEmail,
// //         'serviceName': widget.name,
// //         'description': widget.description,
// //         'price': widget.price,
// //         'date': selectedDate!.toIso8601String().split('T')[0],
// //         'slot': selectedSlot,
// //         'address': address,
// //         'paymentMethod': selectedPaymentMethod,
// //         'providerId': providerId,
// //       });
// //
// //       final appointmentRef =
// //           FirebaseFirestore.instance.collection('appointments').doc();
// //       await appointmentRef.set({
// //         'userName': widget.userName,
// //         'userEmail': widget.userEmail,
// //         // 'providerName': widget.name,
// //         'description': widget.description,
// //         'price': widget.price,
// //         'date': selectedDate!.toIso8601String(),
// //         'slot': selectedSlot,
// //         'address': address,
// //         'paymentMethod': selectedPaymentMethod,
// //         'status': 'booked',
// //         'providerId': widget.providerId,
// //         'serviceName': widget.name,
// //       });
// //       // await FirebaseFirestore.instance.collection('appointments').add(appointmentData);
// //       final providerRef =
// //           FirebaseFirestore.instance.collection('providers').doc(widget.name);
// //       await providerRef.update({
// //         'unavailableSlots': FieldValue.arrayUnion([selectedSlot]),
// //       });
// //       // Show notification to the user
// //       await _showInAppNotification(
// //         'Appointment Confirmed',
// //         'Your appointment on ${selectedDate!.toLocal()} at $selectedSlot is confirmed.',
// //       );
// //
// //       // Show notification to the provider
// //       await _showInAppNotification(
// //         'New Appointment Booked',
// //         '${widget.userName} has booked an appointment for ${widget.name} on ${selectedDate!.toLocal()} at $selectedSlot.',
// //       );
// //
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Appointment booked successfully!')),
// //       );
// //       _showInAppNotification(
// //         'Appointment Confirmed',
// //         'Your appointment on ${selectedDate!.toLocal()} at $selectedSlot is confirmed.',
// //       );
// //
// // // Schedule reminders for the provider and the user
// // final reminderTime = selectedDate!.subtract(const Duration(days: 1));
// //
// // //Reminder for the user
// // scheduleReminder(
// //   'Upcoming Appointment',
// //  'You have an appointment scheduled tomorrow at $selectedSlot.',
// //   reminderTime,
// //  );
// //
// //  //Reminder for the provider
// // scheduleReminder(
// //   'Appointment Reminder',
// //   'You have an appointment with ${widget.userName} tomorrow at $selectedSlot.',
// //   reminderTime,
// //  );
// //
// //       // Navigate to Home screen
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(
// //             builder: (context) => Home()), // Replace with your Home widget
// //         (route) => false, // Remove all routes below
// //       );
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error booking appointment: $e')),
// //       );
// //     }
// //   }
//
//   Future<void> _bookAppointment() async {
//     // Validation checks
//     if (selectedDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a date.')),
//       );
//       return;
//     }
//
//     if (selectedSlot.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a time slot.')),
//       );
//       return;
//     }
//
//     if (address.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter your address.')),
//       );
//       return;
//     }
//
//     if (selectedPaymentMethod.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a payment method.')),
//       );
//       return;
//     }
//
//     // Added pet validation from the second implementation
//     if (selectedPetId == null || selectedPet == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a pet.')),
//       );
//       return;
//     }
//
//     try {
//       String currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? 'No User';
//
//       // Retrieve the provider details
//       final QuerySnapshot providerSnapshot = await FirebaseFirestore.instance
//           .collection('providers')
//           .where('serviceName', isEqualTo: widget.name)
//           .get();
//
//       if (providerSnapshot.docs.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Provider not found for this service.')),
//         );
//         return;
//       }
//
//       final providerData = providerSnapshot.docs.first.data() as Map<String, dynamic>;
//       final String providerId = providerData['providerId'];
//       final String providerName = providerData['providerName'];
//
//       // Payment handling for credit/debit card
//       if (selectedPaymentMethod == "Credit/Debit Card") {
//         bool paymentSuccess = await StripeService.instance
//             .makePayment(widget.userEmail, widget.price);
//
//         if (!paymentSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Payment failed, please try again.')),
//           );
//           return;
//         }
//       }
//
//       // Prepare appointment data
//       Map<String, dynamic> appointmentData = {
//         'providerName': providerName,
//         'providerEmail': widget.userEmail,
//         'serviceName': widget.name,
//         'appointmentDate': selectedDate,
//         'appointmentTime': selectedSlot,
//         'userEmail': currentUserEmail,
//         'address': address,
//         'paymentMethod': selectedPaymentMethod,
//         'petId': selectedPetId,
//         'petName': selectedPet?.name,
//         'description': widget.description,
//         'price': widget.price,
//         'status': 'booked',
//         'providerId': providerId,
//       };
//
//       // Save appointment to Firestore
//       await FirebaseFirestore.instance.collection('appointments').add(appointmentData);
//
//       // Update provider's unavailable slots
//       final providerRef = FirebaseFirestore.instance.collection('providers').doc(widget.name);
//       await providerRef.update({
//         'unavailableSlots': FieldValue.arrayUnion([selectedSlot]),
//       });
//
//       // Notifications
//       await _showInAppNotification(
//         'Appointment Confirmed',
//         'Your appointment on ${selectedDate!.toLocal()} at $selectedSlot is confirmed.',
//       );
//
//       await _showInAppNotification(
//         'New Appointment Booked',
//         '${widget.userName} has booked an appointment for ${widget.name} on ${selectedDate!.toLocal()} at $selectedSlot.',
//       );
//
//       // Schedule reminders
//       final reminderTime = selectedDate!.subtract(const Duration(days: 1));
//
//       scheduleReminder(
//         'Upcoming Appointment',
//         'You have an appointment scheduled tomorrow at $selectedSlot.',
//         reminderTime,
//       );
//
//       scheduleReminder(
//         'Appointment Reminder',
//         'You have an appointment with ${widget.userName} tomorrow at $selectedSlot.',
//         reminderTime,
//       );
//
//       // Show success message and navigate home
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Appointment booked successfully!')),
//       );
//
//       // Navigator.pushAndRemoveUntil(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => _navigateToHome()),
//       //       (route) => false,
//       // );
//
//       // Optional: additional navigation method from the second implementation
//       _navigateToHome();
//       Get.back();
//
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error booking appointment: $e')),
//       );
//     }
//   }
//    Future<void> scheduleReminder(
//     String title, String body, DateTime scheduledDate) async {
//      // Ensure the date is in the future
//      if (scheduledDate.isBefore(DateTime.now())) return;
//
//     final tz.TZDateTime tzScheduledDate =
//          tz.TZDateTime.from(scheduledDate, tz.local);
//
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails(
//      'reminder_channel', // Channel ID
//       'Reminders', // Channel name
//       importance: Importance.high,
//     priority: Priority.high,
//    );
//
//    const NotificationDetails notificationDetails =
//     NotificationDetails(android: androidDetails);
//
//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0, // Notification ID
//     title, // Notification title
//     body, // Notification body
//     tzScheduledDate, // Scheduled time
//     notificationDetails,
//     androidScheduleMode:
//        AndroidScheduleMode.exactAllowWhileIdle, // Updated parameter
//    uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//    );
//  }
//
//   // Select date
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         selectedSlot = ''; // Reset selected slot
//       });
//       await fetchUnavailableSlots(); // Fetch slots for the selected date
//     }
//   }
//
//   void _navigateToHome() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => Home()),
//     );
//     selectedPaymentMethod.isNotEmpty && selectedPetId != null;
//   }
//
//   // Future<void> _bookAppointment() async {
//   //   if (_isValidSelection()) {
//   //     if (selectedPaymentMethod == "Credit/Debit Card") {
//   //       try {
//   //         // Await the payment process and check if it's successful
//   //         bool paymentSuccess = await StripeService.instance
//   //             .makePayment(widget.userEmail, widget.price);
//   //
//   //         if (paymentSuccess) {
//   //           // Proceed with booking the appointment only if the payment was successful
//   //           String currentUserEmail =
//   //               FirebaseAuth.instance.currentUser?.email ?? 'No User';
//   //
//   //           // Confirm booking after payment success
//   //           await FirebaseFirestore.instance.collection('appointments').add({
//   //             'providerName': widget.userName,
//   //             'providerEmail': widget.userEmail,
//   //             'serviceName': widget.name,
//   //             'appointmentDate': selectedDate,
//   //             'appointmentTime': selectedSlot,
//   //             'userEmail': currentUserEmail,
//   //             'address': address,
//   //             'paymentMethod': selectedPaymentMethod,
//   //             'petId': selectedPetId, // Include the selected pet
//   //             'petName': selectedPet?.name, // Include the selected pet's name
//   //           });
//   //           final providerRef =
//   //           FirebaseFirestore.instance.collection('providers').doc(widget.name);
//   //           await providerRef.update({
//   //             'unavailableSlots': FieldValue.arrayUnion([selectedSlot]),
//   //           });
//   //           // Show notification to the user
//   //           await _showInAppNotification(
//   //             'Appointment Confirmed',
//   //             'Your appointment on ${selectedDate!.toLocal()} at $selectedSlot is confirmed.',
//   //           );
//   //
//   //           // Show notification to the provider
//   //           await _showInAppNotification(
//   //             'New Appointment Booked',
//   //             '${widget.userName} has booked an appointment for ${widget.name} on ${selectedDate!.toLocal()} at $selectedSlot.',
//   //           );
//   //
//   //           ScaffoldMessenger.of(context).showSnackBar(
//   //             SnackBar(content: Text('Appointment booked successfully!')),
//   //           );
//   //           // _showInAppNotification(
//   //           //   'Appointment Confirmed',
//   //           //   'Your appointment on ${selectedDate!.toLocal()} at $selectedSlot is confirmed.',
//   //           // );
//   //
//   //
//   //           // ScaffoldMessenger.of(context).showSnackBar(
//   //           //   SnackBar(content: Text('Appointment booked successfully!')),
//   //           // );
//   //           _navigateToHome(); // Navigate to home after booking
//   //           Get.back(); // Navigate to home after booking
//   //         } else {
//   //           // Payment failed, show error message
//   //           ScaffoldMessenger.of(context).showSnackBar(
//   //             SnackBar(content: Text('Payment failed, please try again.')),
//   //           );
//   //         }
//   //       } catch (e) {
//   //         // Handle errors during the payment or booking process
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(content: Text('Error during payment or booking: $e')),
//   //         );
//   //       }
//   //     } else {
//   //       // If payment method is COD, proceed with booking directly
//   //       String currentUserEmail =
//   //           FirebaseAuth.instance.currentUser?.email ?? 'No User';
//   //
//   //       try {
//   //         await FirebaseFirestore.instance.collection('appointments').add({
//   //           'providerName': widget.userName,
//   //           'providerEmail': widget.userEmail,
//   //           'serviceName': widget.name,
//   //           'appointmentDate': selectedDate,
//   //           'appointmentTime': selectedSlot,
//   //           'userEmail': currentUserEmail,
//   //           'address': address,
//   //           'paymentMethod': selectedPaymentMethod,
//   //           'petId': selectedPetId, // Include the selected pet
//   //           'petName': selectedPet?.name, // Include the selected pet's name
//   //         });
//   //
//   //         print("Appointment successfully booked!");
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(content: Text('Appointment booked successfully!')),
//   //         );
//   //         _navigateToHome(); // Navigate to home after booking
//   //         Get.back(); // Navigate to home after booking
//   //       } catch (e) {
//   //         print("Error booking appointment: $e");
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(content: Text('Failed to book appointment: $e')),
//   //         );
//   //       }
//   //     }
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         // content: Text('Please select a valid date, time, address, and payment method'),
//   //         content: Text(
//   //             'Please select a valid date, time, address, pet, and payment method'),
//   //       ),
//   //     );
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Select Appointment',
//           style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: textColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Date Picker
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Select Date:",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "${selectedDate.toLocal()}".split(' ')[0],
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       Icons.calendar_today,
//                       color: textColor,
//                     ),
//                     onPressed: () => _selectDate(context),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//
//               // Time Slot Selection using GridView
//               Text(
//                 "Select Time Slot:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               GridView.builder(
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0,
//                   childAspectRatio: 2.5,
//                 ),
//                 itemCount: timeSlots.length,
//                 itemBuilder: (context, index) {
//                   return ChoiceChip(
//                     label: Text(timeSlots[index]),
//                     selected: selectedSlot == timeSlots[index],
//                     onSelected: (selected) {
//                       _selectTimeSlot(timeSlots[index]);
//                     },
//                     backgroundColor: backgrndclrpurple,
//                     selectedColor: Colors.purple[200],
//                     labelStyle: TextStyle(color: Colors.black),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//
//               // Select Pet Dropdown
//               Text(
//                 "Select Pet:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Obx(() {
//                 // Fetch pets from the PetController
//                 var pets = petController.pets;
//                 if (pets.isEmpty) {
//                   return Center(child: Text("No pets found"));
//                 }
//                 return DropdownButton<String>(
//                   hint: Text("Select your pet"),
//                   value: selectedPetId,
//                   onChanged: (String? newPetId) {
//                     setState(() {
//                       selectedPetId = newPetId;
//                       selectedPet =
//                           pets.firstWhere((pet) => pet.id == newPetId);
//                     });
//                   },
//                   items: pets.map<DropdownMenuItem<String>>((Pet pet) {
//                     return DropdownMenuItem<String>(
//                       value: pet.id,
//                       child: Text(pet.name),
//                     );
//                   }).toList(),
//                 );
//               }),
//               SizedBox(height: 20),
//               // Address Input Field
//               Text(
//                 "Enter Address:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     address = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your address',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Payment Method Selection
//               Text(
//                 "Select Payment Method:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Column(
//                 children: [
//                   ListTile(
//                     title: Text("Credit/Debit Card"),
//                     leading: Radio<String>(
//                       value: "Credit/Debit Card",
//                       groupValue: selectedPaymentMethod,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedPaymentMethod = value!;
//                         });
//                       },
//                     ),
//                   ),
//                   ListTile(
//                     title: Text("Cash on Delivery (COD)"),
//                     leading: Radio<String>(
//                       value: "Cash on Delivery",
//                       groupValue: selectedPaymentMethod,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedPaymentMethod = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//
//               // Confirm Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _bookAppointment;
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: backgrndclrpurple,
//                     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
//                     textStyle: TextStyle(fontSize: 18),
//                   ),
//                   child: Text("Confirm Booking"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:pet/constants/colors.dart';
// import 'package:pet/constants/constants.dart';
// import 'package:pet/features/home/home.dart';
// import 'package:get/get.dart';
// import 'package:timezone/browser.dart';
// // import 'package:timezone/browser.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import '../../../main.dart';
// import '../../payment/service.dart';
// import '../../pets/controller/pet_controller.dart';
// import '../../pets/model/pet_model.dart';
// import '../navigation_menu.dart';
//
// class AppointmentSelectionScreen extends StatefulWidget {
//   final String userName;
//   final String userEmail;
//   final String name;
//   final String description;
//   final double price;
//   final String providerId;
//
//   AppointmentSelectionScreen({
//     required this.userName,
//     required this.userEmail,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.providerId,
//   });
//
//   @override
//   _AppointmentSelectionScreenState createState() =>
//       _AppointmentSelectionScreenState();
// }
//
// class _AppointmentSelectionScreenState
//     extends State<AppointmentSelectionScreen> {
//   DateTime selectedDate = DateTime.now();
//   String selectedSlot = '';
//   String address = ''; // Variable to store the entered address
//   String selectedPaymentMethod = ''; // To store the selected payment method
//   String? selectedPetId; // Store the selected pet's ID
//   Pet? selectedPet; // Store the selected pet object
//
//   List<String> timeSlots = [
//     '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM',
//     '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM',
//     '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM',
//     '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM',
//     '5:00 PM'
//   ];
//
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   final PetController petController = Get.put(PetController());
//
//   // Fetch the pets for the current user
//   @override
//   void initState() {
//     super.initState();
//     petController.fetchPets(userId ?? "");
//   }
//
//   //   Future<void> _showInAppNotification(String title, String body) async {
//   //   const AndroidNotificationDetails androidDetails =
//   //       AndroidNotificationDetails(
//   //     'appointment_channel_id', // Unique channel ID
//   //     'Appointment Notifications', // Channel name
//   //     importance: Importance.high,
//   //     priority: Priority.high,
//   //   );
//   //
//   //   const NotificationDetails platformDetails = NotificationDetails(
//   //     android: androidDetails,
//   //   );
//   //
//   //   await flutterLocalNotificationsPlugin.show(
//   //     0, // Notification ID
//   //     title, // Notification title
//   //     body, // Notification body
//   //     platformDetails,
//   //   );
//   // }
//   // Function to select the date
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate)
//       setState(() {
//         selectedDate = picked;
//       });
//   }
//
//   // Function to select the time slot
//   void _selectTimeSlot(String slot) {
//     setState(() {
//       selectedSlot = slot;
//     });
//   }
//
//   // Validate if all inputs are valid
//   bool _isValidSelection() {
//     return selectedSlot.isNotEmpty &&
//         selectedDate != null &&
//         address.isNotEmpty &&
//         selectedPaymentMethod.isNotEmpty &&
//         selectedPetId != null;
//
//   }
//
//   // Function to handle the booking flow with payment
//   Future<void> _bookAppointment() async {
//     if (_isValidSelection()) {
//       if (selectedPaymentMethod == "Credit/Debit Card") {
//         try {
//           // Await the payment process and check if it's successful
//           bool paymentSuccess =
//           await StripeService.instance.makePayment(widget.userEmail, widget.price);
//
//           if (paymentSuccess) {
//             // Proceed with booking the appointment only if the payment was successful
//             String currentUserEmail =
//                 FirebaseAuth.instance.currentUser?.email ?? 'No User';
//
//             await FirebaseFirestore.instance.collection('appointments').add({
//               'providerName': widget.userName,
//               'providerEmail': widget.userEmail,
//               'serviceName': widget.name,
//               'appointmentDate': selectedDate,
//               'appointmentTime': selectedSlot,
//               'userEmail': currentUserEmail,
//               'address': address,
//               'paymentMethod': selectedPaymentMethod,
//               'petId': selectedPetId,
//               'petName': selectedPet?.name,
//             });
//
//             // Schedule a notification after successful booking
//             await scheduleNotification();
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Appointment booked successfully!')),
//             );
//             Get.to(NavigationMenu()); // Navigate to the navigation menu
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Payment failed, please try again.')),
//             );
//           }
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error during payment or booking: $e')),
//           );
//         }
//       } else {
//         // If payment method is COD, proceed with booking directly
//         String currentUserEmail =
//             FirebaseAuth.instance.currentUser?.email ?? 'No User';
//
//         try {
//           await FirebaseFirestore.instance.collection('appointments').add({
//             'providerName': widget.userName,
//             'providerEmail': widget.userEmail,
//             'serviceName': widget.name,
//             'appointmentDate': selectedDate,
//             'appointmentTime': selectedSlot,
//             'userEmail': currentUserEmail,
//             'address': address,
//             'paymentMethod': selectedPaymentMethod,
//             'petId': selectedPetId,
//             'petName': selectedPet?.name,
//           });
//
//           // Schedule a notification after successful booking
//           await scheduleNotification();
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Appointment booked successfully!')),
//           );
//           Get.to(NavigationMenu());
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error during booking: $e')),
//           );
//         }
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill all required fields.')),
//       );
//     }
//   }
//
//   Future<void> scheduleNotification() async {
//     // Configure notification details
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'appointment_channel',
//       'Appointment Notifications',
//       channelDescription: 'Notifications for scheduled appointments',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     // Set the notification time
//     final scheduledDateTime = tz.TZDateTime.from(
//       selectedDate,
//       tz.local,
//     );
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0, // Notification ID
//       'Appointment Reminder',
//       'You have an appointment at $selectedSlot on ${selectedDate.toLocal()}',
//       scheduledDateTime,
//       // platformChannelSpecifics,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time, // Optional
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Select Appointment',
//           style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: textColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Date Picker
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Select Date:",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "${selectedDate.toLocal()}".split(' ')[0],
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       Icons.calendar_today,
//                       color: textColor,
//                     ),
//                     onPressed: () => _selectDate(context),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//
//               // Time Slot Selection using GridView
//               Text(
//                 "Select Time Slot:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               GridView.builder(
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0,
//                   childAspectRatio: 2.5,
//                 ),
//                 itemCount: timeSlots.length,
//                 itemBuilder: (context, index) {
//                   return ChoiceChip(
//                     label: Text(timeSlots[index]),
//                     selected: selectedSlot == timeSlots[index],
//                     onSelected: (selected) {
//                       _selectTimeSlot(timeSlots[index]);
//                     },
//                     backgroundColor: backgrndclrpurple,
//                     selectedColor: Colors.purple[200],
//                     labelStyle: TextStyle(color: Colors.black),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//
//               // Select Pet Dropdown
//               Text(
//                 "Select Pet:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Obx(() {
//                 // Fetch pets from the PetController
//                 var pets = petController.pets;
//
//                 if (pets.isEmpty) {
//                   return Center(child: Text("No pets found"));
//                 }
//
//                 return DropdownButton<String>(
//                   hint: Text("Select your pet"),
//                   value: selectedPetId,
//                   onChanged: (String? newPetId) {
//                     setState(() {
//                       selectedPetId = newPetId;
//                       selectedPet = pets.firstWhere((pet) => pet.id == newPetId);
//                     });
//                   },
//                   items: pets.map<DropdownMenuItem<String>>((Pet pet) {
//                     return DropdownMenuItem<String>(
//                       value: pet.id,
//                       child: Text(pet.name),
//                     );
//                   }).toList(),
//                 );
//               }),
//               SizedBox(height: 20),
//
//               // Address Input Field
//               Text(
//                 "Enter Address:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     address = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your address',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Payment Method Selection
//               Text(
//                 "Select Payment Method:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Column(
//                 children: [
//                   ListTile(
//                     title: Text("Credit/Debit Card"),
//                     leading: Radio<String>(
//                       value: "Credit/Debit Card",
//                       groupValue: selectedPaymentMethod,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedPaymentMethod = value!;
//                         });
//                       },
//                     ),
//                   ),
//                   ListTile(
//                     title: Text("Cash on Delivery (COD)"),
//                     leading: Radio<String>(
//                       value: "Cash on Delivery",
//                       groupValue: selectedPaymentMethod,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedPaymentMethod = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//
//               // Confirm Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _bookAppointment,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: backgrndclrpurple,
//                     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
//                     textStyle: TextStyle(fontSize: 18),
//                   ),
//                   child: Text("Confirm Booking"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

