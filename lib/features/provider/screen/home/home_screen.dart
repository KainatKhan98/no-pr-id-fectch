import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/features/home/appointment/provider%20appointment/upcomingprovider.dart';
import 'package:pet/features/provider/screen/home/provider_app_bar.dart';
import 'package:pet/features/provider/screen/home/reviews/reviews.dart';
import 'package:pet/features/provider/screen/home/services/services.dart';
import '../../controller/provider_controller.dart';
import '../profle/provider_profile.dart';
import 'about/about.dart';
import 'appointment/appointment.dart';
import 'earning/earning.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});

  @override

  Widget build(BuildContext context) {
    final controller1 = Get.put(ProviderController());

    return Scaffold(
      backgroundColor: logoPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProviderAppBar(), // Moved app bar here
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileSection(),
                  const SizedBox(height: 20),
                  AboutSection(providerId: FirebaseAuth.instance.currentUser!.uid, initialBio: controller1.user.value.bio,),
                  const SizedBox(height: 20),
                  ServiceOverview(providerId: FirebaseAuth.instance.currentUser!.uid,),
                  const SizedBox(height: 20),
                  const AppointmentSection(),
                  const SizedBox(height: 20),
                   AppointmentsOverview(),
                  const SizedBox(height: 20,),
                  const EarningsOverview(),
                  const SizedBox(height: 20),
                  const ReviewsSection(),
                  // _buildReviewsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}