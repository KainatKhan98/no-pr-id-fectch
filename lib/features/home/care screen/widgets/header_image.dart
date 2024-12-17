import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';
import '../../../../../constants/images.dart';

class PetImageHeader extends StatelessWidget {
  final String headerImage;
  const PetImageHeader({Key? key, required this.headerImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: logoPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image(
        image: AssetImage(headerImage),
        fit: BoxFit.contain,
      ),
    );
  }
}