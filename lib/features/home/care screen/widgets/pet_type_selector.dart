import 'package:flutter/material.dart';
import '../../../../../constants/images.dart';

class PetTypeSelector extends StatelessWidget {
  final void Function(String pet) onPetSelected;
  final bool isCatLoading, isDogLoading, isRabbitLoading;

  const PetTypeSelector({
    required this.onPetSelected,
    required this.isCatLoading,
    required this.isDogLoading,
    required this.isRabbitLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PetTypeButton(
          image: cat,
          isLoading: isCatLoading,
          onTap: () => onPetSelected('cat'),
        ),
        PetTypeButton(
          image: dog,
          isLoading: isDogLoading,
          onTap: () => onPetSelected('dog'),
        ),
        PetTypeButton(
          image: rabbit,
          isLoading: isRabbitLoading,
          onTap: () => onPetSelected('rabbit'),
        ),
      ],
    );
  }
}

class PetTypeButton extends StatelessWidget {
  final String image;
  final bool isLoading;
  final VoidCallback onTap;

  const PetTypeButton({
    required this.image,
    required this.isLoading,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              maxRadius: 45.0,
              backgroundImage: AssetImage(image),
            ),
            if (isLoading)
              const CircularProgressIndicator(
                color: Colors.purple,
              ),
          ],
        ),
      ),
    );
  }
}