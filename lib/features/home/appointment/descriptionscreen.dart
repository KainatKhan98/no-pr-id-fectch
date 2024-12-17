
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet/constants/constants.dart';
import 'package:pet/constants/text.dart';

import 'appointment_service.dart';
import '../home.dart';

import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final int duration;
  final String userName;
  final String userEmail;
  final String profileImageUrl;
  final String providerId; // New field for providerId

  BookingScreen({
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.userName,
    required this.userEmail,
    required this.profileImageUrl,
    required this.providerId, // Include providerId in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Provider Details"),
        backgroundColor: Colors.purple, // Adjusted the color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : null,
                  backgroundColor: Colors.grey[200],
                  child: profileImageUrl.isEmpty
                      ? Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey[600],
                  )
                      : null,
                ),
              ),
              SizedBox(height: 16),

              // Title Section
              Text(
                "Provider Details",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Provider Information Section
              _buildInfoCard(
                context,
                title: "Provider Information",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText("Name: ", userName),
                    SizedBox(height: 8),
                    _buildRichText("Email: ", userEmail),
                    SizedBox(height: 8),
                    _buildRichText("Provider ID: ", providerId), // Optionally display providerId
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Service Details Section
              _buildInfoCard(
                context,
                title: "Service Details",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText("Service: ", name),
                    SizedBox(height: 8),
                    _buildRichText("Description: ", description),
                    SizedBox(height: 8),
                    _buildRichText("Price: ", "\$$price"),
                    SizedBox(height: 8),
                    _buildRichText("Duration: ", "$duration minutes"),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Custom navigation with animation using PageRouteBuilder
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => AppointmentSelectionScreen(
                            userName: userName,
                            userEmail: userEmail,
                            name: name,
                            description: description,
                            price: price,
                            providerId: providerId,
                            // duration: duration
                          ),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            // Custom animation: Slide transition
                            var begin = Offset(1.0, 0.0); // From right to left
                            var end = Offset.zero; // Ending position
                            var curve = Curves.easeInOut; // Animation curve

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(position: offsetAnimation, child: child); // Slide transition
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgrndclrpurple, // Button color
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text("Book Appointment"), // Simple button text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for building rich text
  Widget _buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
          TextSpan(
            text: value,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // Helper function for building cards with consistent size
  Widget _buildInfoCard(BuildContext context, {required String title, required Widget content}) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9, // Ensuring consistent width for both cards
        child: Card(
          elevation: 5,
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}



