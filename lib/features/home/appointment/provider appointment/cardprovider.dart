import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Assuming Firestore is being used
import 'package:pet/features/home/appointment/provider%20appointment/upcomingprovider.dart';
import 'package:pet/features/home/appointment/upcoming%20Appointments.dart';

import '../../../provider/screen/home/home_screen.dart';

class CardAppointmentProvider extends StatelessWidget {
  final String appointmentId;
  final String serviceName;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String userName;
  final String paymentMethod;
  final String address;
  final Function? modifyAppointment;
  final Function? cancelAppointment;
  final Function? markAsDone; // New callback for "Done" button

  CardAppointmentProvider({
    required this.appointmentId,
    required this.serviceName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.userName,
    required this.paymentMethod,
    required this.address,
    this.modifyAppointment,
    this.cancelAppointment,
    this.markAsDone, // Initialize the new callback
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'User: $userName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text('Service: $serviceName'),
                  Text('Date: ${appointmentDate.toLocal()}'),
                  Text('Time: $appointmentTime'),
                  Text('Payment Method: $paymentMethod'),
                  Text('Address: $address'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Modify Button
                  if (modifyAppointment != null)
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => modifyAppointment!(),
                    ),
                  // Cancel Button (Only if cancelAppointment is provided)
                  if (cancelAppointment != null)
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => cancelAppointment!(appointmentId),
                    ),
                  // Done Button (Only if markAsDone is provided)
                  if (markAsDone != null)
                    IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.green),
                      onPressed: () => markAsDone!(appointmentId, context), // Pass context
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

// Function to mark the appointment as done
// void markAppointmentAsDone(String appointmentId, BuildContext context) {
//   // Update the appointment status or other necessary actions
//   FirebaseFirestore.instance
//       .collection('appointments')
//       .doc(appointmentId)
//       .update({'status': 'completed'})
//       .then((_) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Appointment marked as completed')),
//     );
//     // Navigate to the completed appointments screen
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CompleteProviderAppointmentsScreen()), // Navigate to CompletedAppointmentsScreen
//     );
//   }).catchError((error) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Failed to mark appointment as completed')),
//     );
//   });
// }

void markAppointmentAsDone(String appointmentId, BuildContext context) {
  final appointmentsCollection = FirebaseFirestore.instance.collection('appointments');

  // Update the status of the appointment to "completed"
  appointmentsCollection.doc(appointmentId).update({'status': 'completed'}).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Appointment marked as completed')),
    );

    //Optionally navigate to a specific screen if needed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProviderHomeScreen()),
    );
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to mark appointment as completed')),
    );
  });
}

