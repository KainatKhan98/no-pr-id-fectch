import 'package:flutter/material.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/constants/sizes.dart';
import '../../../constants/colors.dart';
import '../care screen/dental/dental_screen.dart';
import '../care screen/illness_and_injuries/illness_and_injuries.dart';
import '../care screen/litter_training/litter training.dart';
import '../care screen/pet_sitting/pet sitting.dart';
import '../care screen/pet_walking/pet walking.dart';
import '../care screen/routine_checkup/routinecheckup.dart';
import '../care screen/vaccination/vaccinescreen.dart';


class CareScreen extends StatelessWidget {
  const CareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: const Text(
                  "Pet Care Services",
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
                ),
                elevation: 0, // Remove shadow
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildServiceCard(context, 'Vaccination', 'Keep your pet safe with regular vaccines.', vaccination, const VaccinationScreen()),
                  SizedBox(height: Sizes.s*1.5,),
                  _buildServiceCard(context, 'Dental Care', 'Ensure your pet has a healthy mouth and teeth.', dental, const DentalCare()),
                  SizedBox(height: Sizes.s*1.5,),
                  _buildServiceCard(context, 'Routine Checkup', 'Regular checkups for your pet’s health.', routineCheckup, const RoutineCheckup()),
                  SizedBox(height: Sizes.s*1.5,),
                  _buildServiceCard(context, 'Illness & Injuries', 'Immediate care for any illness or injury.', illness, const IllnessAndInjuries()),
                  SizedBox(height: Sizes.s*1.5,),
                  _buildServiceCard(context, 'Pet Sitting', 'Professional pet sitting when you’re away.',petSitting, const PetSitting()),
                  SizedBox(height: Sizes.s*1.5,),
                  _buildServiceCard(context, 'Pet Walking', 'Daily walks to keep your pet healthy.', petWalking, const PetWalking()),
                  SizedBox(height: Sizes.s*1.5,),
                  _buildServiceCard(context, 'Litter Training', 'Help your pet learn proper litter habits.', litterTraining, const LitterTraining()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String description, String imagePath, Widget nextScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, animation, secondaryAnimation) => nextScreen,
            transitionsBuilder: (BuildContext context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeIn;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        height: 120,
        width: double.infinity, // Adjust width to fill the available space
        decoration: BoxDecoration(
          color: logoPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image(image: AssetImage(imagePath), width: 70, height: 70,),
              const SizedBox(width: 10), // Added spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: text2),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: 200,
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200, color: text2),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}