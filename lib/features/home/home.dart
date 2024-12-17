import 'package:flutter/material.dart';
import 'package:pet/common/widgets/section_heading/section_heading.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/features/home/appointment/upcoming%20Appointments.dart';
import 'package:pet/features/home/widgets/community.dart';
import 'package:pet/features/home/widgets/consult.dart';
import 'package:pet/features/home/widgets/pet_services.dart';
import 'package:pet/features/home/widgets/searchbar.dart';
import 'package:pet/utils/helpers/helpers.dart';
import 'app_bar.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: logoPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: HelpFunctions.screenWidth(),
              child: const MyAppBar(),
            ),

            // Search Bar
            const Searchbar(),
            SizedBox(height: Sizes.defaultPadding,),

            Container(
              width: HelpFunctions.screenWidth(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Adjust the radius as needed
                  topRight: Radius.circular(20.0), // Adjust the radius as needed
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(Sizes.defaultPadding),
                child: Column(
                    children: [
                      // Consult
                      SizedBox(height: Sizes.s*1.5,),
                      const SectionHeading(title: "Consult", showActionButton: false,),
                      SizedBox(height: Sizes.s*1.5,),
                      const ConsultSection(),
                      SizedBox(height: Sizes.m,),

                      // Services
                      const SectionHeading(title: "Services", showActionButton: false,),
                      SizedBox(height: Sizes.s*1.5,),
                      const PetServicesSection(),
                      SizedBox(height: Sizes.m,),

                      const SectionHeading(title: "Appointment Details", showActionButton: false,),
                      SizedBox(height: Sizes.s*1.5,),
                      AppointmentsOverview(),
                      SizedBox(height: Sizes.m,),


                      // Community
                      const SectionHeading(title: "Community", showActionButton: false,),
                      SizedBox(height: Sizes.s*1.5,),
                      const Community(),
                      SizedBox(height: Sizes.m,),
                    ]
                ),
              ),
            )],
        ),
      ),
    );
  }
}
