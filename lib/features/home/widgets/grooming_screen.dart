import 'package:flutter/material.dart';
import 'package:pet/constants/images.dart';
import '../../../constants/colors.dart';
import '../grooming screen/bathing_and_brushing/bathing_and_brushing.dart';
import '../grooming screen/deshedding/deshedding_and_haircutting.dart';
import '../grooming screen/styling/styling_and_touches.dart';

class GroomingScreen extends StatefulWidget {
  const GroomingScreen({super.key});

  @override
  State<GroomingScreen> createState() => _GroomingScreenState();
}

class _GroomingScreenState extends State<GroomingScreen> {
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
                  "Grooming Services",
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
                  _buildServiceCard(context, 'Bathing & Brushing', 'Refresh your pet with a soothing bath and brush.', vaccination, const BathingAndBrushing()),
                  const SizedBox(height: 10),
                  _buildServiceCard(context, 'Haircutting', 'Tame shedding and style your pets coat.', dental, const DesheddingAndCutting()),
                  const SizedBox(height: 10),
                  _buildServiceCard(context, 'Styling & Touches', 'Add flair with stylish cuts and final touches.', routineCheckup, const StylingAndTouches()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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