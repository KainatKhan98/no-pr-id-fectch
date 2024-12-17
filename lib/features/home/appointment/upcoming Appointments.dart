import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet/constants/constants.dart';
import 'cancel appoitments.dart';
import 'displayappointment.dart';
import 'modification screen.dart';



class UpcomingAppointmentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('userEmail', isEqualTo: currentUserEmail)
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

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Appointment Details'),
            ),
              body: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                // final appointment = appointments[index].data() as Map<String, dynamic>;
                final appointmentId = appointments[index].id; // Get the appointment ID

                final appointmentData = appointment.data() as Map<String, dynamic>;

                return CardAppointment(

                  appointmentId: appointment.id,
                  serviceName: appointmentData['serviceName'] ?? 'Service',
                  appointmentDate: (appointmentData['appointmentDate'] as Timestamp).toDate(),
                  appointmentTime: appointmentData['appointmentTime'] ?? 'Time',
                  providerName: appointmentData['providerName'] ?? 'Provider',
                  onModify: () {
                    // Navigate to ModifyAppointmentScreen when modify icon is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ModifyAppointmentScreen(
                          appointmentId: appointmentId, // Pass appointment ID
                          serviceName: appointment['serviceName'],
                          appointmentDate: (appointment['appointmentDate'] as Timestamp).toDate(),
                          appointmentTime: appointment['appointmentTime'],
                          providerName: appointment['providerName'],
                        ),
                      ),
                    );
                  },
                  cancelAppointment: (appointmentId) {
                    cancelAppointment(appointmentId); // Call the cancel function
                  },
                );
              },
            ),
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
              navigateTo(context, UpcomingAppointmentsSection());
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
              navigateTo(context, const CompletedAppointmentsScreen());
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

          // Cancelled Appointments
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



class CompletedAppointmentsScreen extends StatelessWidget {
  const CompletedAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Completed Appointments")),
      body: const Center(child: Text("Completed Appointments List")),
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
