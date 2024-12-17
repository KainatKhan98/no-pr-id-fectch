import 'package:flutter/material.dart';

import '../../../../../constants/constants.dart';

class PetTipsSection extends StatelessWidget {
  final String petType;
  final int catClickCount, dogClickCount, rabbitClickCount;

  const PetTipsSection({
    required this.petType,
    required this.catClickCount,
    required this.dogClickCount,
    required this.rabbitClickCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tips = getPetTips(petType, catClickCount, dogClickCount, rabbitClickCount);
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tips[index], style: body),
          );
        },
      ),
    );
  }
}

List<String> getPetTips(String petType, int catClicks, int dogClicks, int rabbitClicks) {
  List<String> tips = [];

  switch (petType) {
    case 'cat':
      tips = catClicks % 3 == 0
          ? [
        "1. Brush your cat's teeth regularly to prevent plaque buildup.",
        "2. Use cat-friendly toothpaste, never human toothpaste.",
        "3. Offer dental treats to help maintain your cat’s oral hygiene.",
        "4. Schedule regular dental checkups with your vet.",
        "5. Provide toys that help clean your cat's teeth as they chew.",
      ]
          : catClicks % 3 == 1
          ? [
        "1. Start dental care at an early age to get your cat used to it.",
        "2. Check your cat's gums for any signs of redness or swelling.",
        "3. Use a soft-bristled toothbrush designed for cats.",
        "4. Bad breath can be a sign of dental issues, so keep an eye on it.",
        "5. Add dental health supplements to your cat's diet if recommended by your vet.",
      ]
          : [
        "1. Regular brushing reduces the risk of gum disease in cats.",
        "2. Look for cat-specific dental chews to help clean teeth.",
        "3. Avoid giving your cat hard objects that could damage their teeth.",
        "4. Check for signs of tartar buildup on your cat's teeth regularly.",
        "5. If your cat resists tooth brushing, consult your vet for alternatives.",
      ];
      break;

    case 'dog':
      tips = dogClicks % 3 == 0
          ? [
        "1. Brush your dog's teeth daily with dog-safe toothpaste.",
        "2. Provide chew toys that promote dental health.",
        "3. Schedule annual dental checkups for your dog.",
        "4. Watch for signs of dental problems like bad breath or difficulty chewing.",
        "5. Use dental rinses or water additives recommended by your vet.",
      ]
          : dogClicks% 3 == 1
          ? [
        "1. Start dental care early to prevent gum disease in dogs.",
        "2. Look for dental treats that help reduce plaque and tartar buildup.",
        "3. Regular brushing is the best way to maintain your dog's oral health.",
        "4. Avoid giving your dog bones or hard chews that could crack their teeth.",
        "5. Check your dog’s mouth regularly for any signs of pain or infection.",
      ]
          : [
        "1. Keep your dog's teeth clean with regular brushing and dental chews.",
        "2. Dental diseases can affect your dog's overall health, so take it seriously.",
        "3. Use finger toothbrushes if your dog resists regular brushes.",
        "4. Keep an eye on your dog's breath; bad breath could signal dental issues.",
        "5. Make dental care part of your dog's routine for long-term health.",
      ];
      break;

    case 'rabbit':
      tips = rabbitClicks % 3 == 0
          ? [
        "1. Provide plenty of hay, which helps naturally wear down rabbit teeth.",
        "2. Check your rabbit's teeth regularly for signs of overgrowth.",
        "3. Give chew toys to help keep your rabbit's teeth healthy.",
        "4. Monitor your rabbit’s eating habits; dental issues can cause a loss of appetite.",
        "5. Schedule regular vet checkups to monitor your rabbit's dental health.",
      ]
          : rabbitClicks % 3 == 1
          ? [
        "1. Avoid sugary treats, which can contribute to dental problems in rabbits.",
        "2. Ensure your rabbit is chewing properly to keep their teeth in check.",
        "3. Dental issues in rabbits can lead to serious health problems, so consult your vet regularly.",
        "4. If you notice drooling, it could be a sign of dental issues.",
        "5. Make sure your rabbit's diet includes a variety of fibrous foods to help wear down their teeth.",
      ]
          : [
        "1. Long teeth can cause pain and eating problems in rabbits, so monitor regularly.",
        "2. Provide wooden chew toys or natural branches to keep your rabbit's teeth trimmed.",
        "3. Overgrown teeth can cause injuries to your rabbit's mouth and jaw.",
        "4. Look for signs like weight loss, which could indicate dental issues.",
        "5. Regular vet visits are essential for preventing dental diseases in rabbits.",
      ];
      break;

    default:
      tips = ["Invalid pet type selected."];
      break;
  }

  return tips;
}