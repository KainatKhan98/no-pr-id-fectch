import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CancelAppointmentScreen extends StatelessWidget {
  final String appointmentId;

  CancelAppointmentScreen({required this.appointmentId});

  void cancelAppointment(BuildContext context) {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId)
        .delete()
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment Cancelled')),
      );
      Navigator.pop(context); // Go back to the previous screen
    })
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cancel Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to cancel this appointment?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => cancelAppointment(context),
              child: Text('Yes, Cancel Appointment'),
              style: ElevatedButton.styleFrom(iconColor: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen without cancelling
              },
              child: Text('No, Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
