import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderModifyScreen extends StatefulWidget {
  final String appointmentId;
  final DateTime appointmentDate;
  final String appointmentTime;

  ProviderModifyScreen({
    required this.appointmentId,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  @override
  _ProviderModifyScreenState createState() => _ProviderModifyScreenState();
}

class _ProviderModifyScreenState extends State<ProviderModifyScreen> {
  TextEditingController appointmentTimeController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    appointmentTimeController.text = widget.appointmentTime;
    selectedDate = widget.appointmentDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(), // Prevent selection of past dates
      lastDate: DateTime(2030),
    );

    if (newDate != null && newDate != selectedDate) {
      setState(() {
        selectedDate = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modify Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Picker
            ListTile(
              title: Text('Appointment Date: ${selectedDate.toLocal().toString().split(' ')[0]}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 20),
            // Time Input
            TextField(
              controller: appointmentTimeController,
              decoration: InputDecoration(
                labelText: 'Appointment Time (e.g., 10:00 AM)',
                hintText: 'Enter new appointment time',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate and update the appointment
                String updatedTime = appointmentTimeController.text.trim();

                if (updatedTime.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid time')),
                  );
                  return;
                }

                FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(widget.appointmentId)
                    .update({
                  'appointmentDate': Timestamp.fromDate(selectedDate),
                  'appointmentTime': updatedTime,
                }).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Appointment Updated Successfully')),
                  );
                  Navigator.pop(context);
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update appointment: $error')),
                  );
                });
              },
              child: Text('Update Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
