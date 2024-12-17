import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/features/home/widgets/pet_shop.dart';
import 'package:pet/features/home/widgets/pet_taxi.dart';
import '../../../constants/colors.dart';
import 'care_screen.dart';
import 'grooming_screen.dart';


class PetServicesSection extends StatelessWidget {
  const PetServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.to(() => const CareScreen()),
          child: const ServiceIcon(
            icon: Icons.pets,
            label: 'Care',
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => const GroomingScreen()),
          child: const ServiceIcon(
            icon: Icons.content_cut,
            label: 'Grooming',
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() =>const PetTaxi()),
          child: const ServiceIcon(
            icon: Icons.local_taxi,
            label: 'Taxi',
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => const PetShop()),
          child: const ServiceIcon(
            icon: Icons.shopping_cart,
            label: 'Shop',
          ),
        ),
      ],
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceIcon({super.key, 
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: logoPurple,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Icon(
            icon,
            size: 35.0,
            color: text2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
