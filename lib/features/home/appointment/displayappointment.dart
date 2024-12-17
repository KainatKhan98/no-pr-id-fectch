import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class CardAppointment extends StatelessWidget {
  final String appointmentId;
  final String serviceName;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String providerName;
  final VoidCallback onModify;
  final Function(String) cancelAppointment;

  const CardAppointment({
    Key? key,
    required this.appointmentId,
    required this.serviceName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.providerName,
    required this.onModify,
    required this.cancelAppointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 5,  // Adds shadow to the card for a more elevated look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),  // Rounded corners for the card
      ),
      color: backgrndclrpurple,  //
      // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(serviceName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${appointmentDate.toLocal()}'.split(' ')[0]),
            Text('Time: $appointmentTime'),
            Text('Provider: $providerName'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onModify,
            ),
            IconButton(
              icon: const Icon(Icons.cancel, color: Colors.red),
              onPressed: () {
                // Show confirmation dialog before cancelling
                _showCancelConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Show a confirmation dialog before cancelling the appointment
  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Cancellation'),
          content: const Text('Are you sure you want to cancel this appointment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog without cancelling
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                // Cancel the appointment if user confirms
                await cancelAppointment(appointmentId);
                Navigator.of(context).pop(); // Close the dialog

                // Show snackbar to indicate cancellation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Appointment cancelled successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
