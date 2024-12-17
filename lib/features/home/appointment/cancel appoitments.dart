import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> cancelAppointment(String appointmentId) async {
  try {
    // Delete the appointment document from Firestore
    await FirebaseFirestore.instance.collection('appointments').doc(appointmentId).delete();

    print('Appointment cancelled and removed successfully');
  } catch (e) {
    print('Error cancelling appointment: $e');
  }
}
