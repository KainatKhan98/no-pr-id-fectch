import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle headings = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: textColor,
);
const TextStyle body = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);
const TextStyle bodybold = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const TextStyle heading2 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

const Color btnclr = Color(0xffADA7FF);
const Color bckgndclryellow = Color(0xffE9BC52);
const Color backgrndclrpurple = Color(0xffADA7FF);

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Widget targetScreen;

  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.targetScreen,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (BuildContext context, animation, secondaryAnimation) => targetScreen,
          transitionsBuilder: (BuildContext context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.bounceIn;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffADA7FF),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
class bulletpointss extends StatelessWidget {
  final String point;
  const bulletpointss({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.brightness_1,size: 10,),
      title: Text(point,style: body,),
      // contentPadding: EdgeInsets.zero,
    );
  }
}


class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const ButtonIcon({super.key, 
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgrndclrpurple, // Use provided background color
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded borders
        ),
      ),
      child: Icon(icon, color: Colors.white), // Use provided icon color
    );
  }
}

