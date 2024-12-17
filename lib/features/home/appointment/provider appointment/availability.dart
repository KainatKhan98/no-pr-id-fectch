import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvailableTimeslotsPage extends StatefulWidget {
  final String providerEmail;

  AvailableTimeslotsPage({required this.providerEmail});

  @override
  _AvailableTimeslotsPageState createState() => _AvailableTimeslotsPageState();
}

class _AvailableTimeslotsPageState extends State<AvailableTimeslotsPage> {
  late Future<List<String>> _availableTimeslots;

  @override
  void initState() {
    super.initState();
    _availableTimeslots = fetchAvailableTimeslots(widget.providerEmail);
  }

  // Fetch available timeslots from Firestore for a specific provider
  Future<List<String>> fetchAvailableTimeslots(String providerId) async {
    final providerTimeslotsRef = FirebaseFirestore.instance
        .collection('provider_timeslots')
        .doc(providerId);

    final docSnapshot = await providerTimeslotsRef.get();

    if (!docSnapshot.exists) {
      throw Exception('No available timeslots for this provider.');
    }

    // Extract the available timeslots from the document
    List<String> availableTimes = List<String>.from(docSnapshot['available_times']);

    return availableTimes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Timeslots for ${widget.providerEmail}'),
      ),
      body: FutureBuilder<List<String>>(
        future: _availableTimeslots,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No available timeslots.'));
          } else {
            List<String> availableTimes = snapshot.data!;
            return ListView.builder(
              itemCount: availableTimes.length,
              itemBuilder: (context, index) {
                final timeslot = availableTimes[index];
                return ListTile(
                  title: Text('Timeslot: $timeslot'),
                  onTap: () {
                    // Handle selecting the timeslot (e.g., navigate to booking page)
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}



Future<void> saveTimeslotsForProvider(String providerEmail, List<String> timeslots) async {
  try {
    // Reference to the Firestore collection for provider timeslots
    final providerTimeslotsRef = FirebaseFirestore.instance.collection('provider_timeslots');

    // Add or update the timeslots for the provider
    await providerTimeslotsRef.doc(providerEmail).set({
      'available_times': timeslots, // Store the array of available timeslots
    }, SetOptions(merge: true)); // Merge if document exists, else create it

    print("Timeslots saved successfully for provider: $providerEmail");
  } catch (e) {
    print("Error saving timeslots: $e");
  }
}
void saveProviderTimeslots() {
  String providerEmail = "provider@example.com"; // Example provider email
  List<String> timeslots = [
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

  saveTimeslotsForProvider(providerEmail, timeslots);
}
