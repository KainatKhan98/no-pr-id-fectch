import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet/features/home/appointment/provider%20appointment/providercancel.dart';
import 'package:pet/features/home/appointment/provider%20appointment/providermodify.dart';
import '../../../../constants/constants.dart';
import 'cardprovider.dart'; // Import the CardAppointmentProvider

class UpcomingProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch the logged-in provider's email
    final String currentProviderEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('providerEmail', isEqualTo: currentProviderEmail)
          // .where('status', isNotEqualTo: 'completed') // Fetch appointments not marked as completed
          .orderBy('appointmentDate', descending: false)
          .snapshots(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load appointments'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No upcoming appointments',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final appointments = snapshot.data!.docs;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Upcoming Appointments'),
          ),
          body: ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              final appointmentData = appointment.data() as Map<String, dynamic>;

              // Extract user name by splitting the email
              final userName = appointmentData['userEmail']?.split('@')[0] ?? 'Unknown User';
              final address = appointmentData['address'] ?? 'Address not provided';

              return CardAppointmentProvider(
                appointmentId: appointment.id,
                serviceName: appointmentData['serviceName'] ?? 'Service',
                appointmentDate: (appointmentData['appointmentDate'] as Timestamp).toDate(),
                appointmentTime: appointmentData['appointmentTime'] ?? 'Time',
                userName: userName,
                paymentMethod: appointmentData['paymentMethod'] ?? 'Unknown Payment',
                address: address,
                modifyAppointment: () {
                  // Navigate to the updated ProviderModifyScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProviderModifyScreen(
                        appointmentId: appointment.id,
                        appointmentDate: (appointmentData['appointmentDate'] as Timestamp).toDate(),
                        appointmentTime: appointmentData['appointmentTime'] ?? 'Time',
                      ),
                    ),
                  );
                },
                cancelAppointment: (appointmentId) {
                  // Navigate to the CancelAppointmentScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CancelAppointmentScreen(appointmentId: appointmentId),
                    ),
                  );
                }, markAsDone: markAppointmentAsDone,
              );
            },
          ),
        );
      },
    );
  }
}


class AppointmentsOverview extends StatefulWidget {
  const AppointmentsOverview({super.key});

  @override
  State<AppointmentsOverview> createState() => _AppointmentsOverviewState();
}

class _AppointmentsOverviewState extends State<AppointmentsOverview> {
  // Navigation with animation
  void navigateTo(BuildContext context, Widget nextScreen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // Start from bottom
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgrndclrpurple,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upcoming Appointments
          GestureDetector(
            onTap: () {
              navigateTo(context, UpcomingProviderScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Upcoming Appointments",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
          const Divider(),

          // Completed Appointments
          GestureDetector(
            onTap: () {
              navigateTo(context, const CompleteProviderAppointmentsScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Completed Appointments",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
          // const Divider(),
          //
          // // Cancelled Appointments
          // GestureDetector(
          //   onTap: () {
          //     navigateTo(context, const CancelledAppointmentsScreen());
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text(
          //         "Cancelled Appointments",
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       const Icon(Icons.arrow_forward),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}


class CompleteProviderAppointmentsScreen extends StatelessWidget {
  const CompleteProviderAppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Completed Provider Appointments")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('status', isEqualTo: 'completed') // Filter for completed appointments
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching appointments'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No completed appointments'));
          }

          final completedAppointments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: completedAppointments.length,
            itemBuilder: (context, index) {
              final appointment = completedAppointments[index];
              // final appointment = appointments[index];
              final appointmentData = appointment.data() as Map<String, dynamic>;

              // Extract user name by splitting the email
              final userName = appointmentData['userEmail']?.split('@')[0] ?? 'Unknown User';
              final address = appointmentData['address'] ?? 'Address not provided';

              return CardAppointmentProvider(
                appointmentId: appointment.id,
                serviceName: appointment['serviceName'] ?? 'Service',
                appointmentDate: (appointment['appointmentDate'] as Timestamp).toDate(),
                appointmentTime: appointment['appointmentTime'] ?? 'Time',
                userName: userName,
                paymentMethod: appointmentData['paymentMethod'] ?? 'Unknown Payment',
                address: address,
                // modifyAppointment: () {
                //   // Navigate to the updated ProviderModifyScreen
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ProviderModifyScreen(
                //         appointmentId: appointment.id,
                //         appointmentDate: (appointmentData['appointmentDate'] as Timestamp).toDate(),
                //         appointmentTime: appointmentData['appointmentTime'] ?? 'Time',
                //       ),
                //     ),
                //   );
                // },
                // cancelAppointment: (appointmentId) {
                //   // Navigate to the CancelAppointmentScreen
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => CancelAppointmentScreen(appointmentId: appointmentId),
                //     ),
                //   );
                // },
                // markAsDone: markAppointmentAsDone,
              );
            },
          );
        },
      ),
    );
  }
}



class CancelledAppointmentsScreen extends StatelessWidget {
  const CancelledAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cancelled Appointments")),
      body: const Center(child: Text("Cancelled Appointments List")),
    );
  }
}