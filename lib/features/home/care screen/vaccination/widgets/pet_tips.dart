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
        "1. Keep your cat calm before vaccination.",
        "2. Ensure your cat is healthy and not under stress.",
        "3. Monitor your cat for any side effects post-vaccination.",
        "4. Schedule annual booster vaccinations to maintain immunity.",
        "5. Give your cat a comfortable space to rest after vaccination.",
      ]
          : catClicks % 3 == 1
          ? [
        "1. Make sure your cat has not had any recent illnesses before vaccination.",
        "2. Keep your cat hydrated before and after the vaccination process.",
        "3. Consult your vet about multi-vaccine shots if required.",
        "4. Vaccinate your cat at an early age for best results.",
        "5. Watch for any unusual behavior post-vaccination and consult your vet if needed.",
      ]
          : [
        "1. Cats may experience mild fever after vaccination.",
        "2. Keep your cat indoors for a few days post-vaccination.",
        "3. Ensure proper diet to boost your cat’s immune system.",
        "4. Schedule a follow-up appointment if your cat shows any symptoms.",
        "5. Avoid stressful activities for your cat after vaccination.",
      ];
      break;

    case 'dog':
      tips = dogClicks % 3 == 0
          ? [
        "1. Give your dog a treat after the vaccination to keep them happy.",
        "2. Ensure your dog is up to date with its vaccination schedule.",
        "3. Provide fresh water and a cozy space post-vaccination.",
        "4. Avoid strenuous activities for your dog for a day after the vaccination.",
        "5. Ensure your dog is well-exercised before the vet visit.",
      ]
          : dogClicks % 3 == 1
          ? [
        "1. Keep your dog active post-vaccination to minimize discomfort.",
        "2. Follow your vet’s instructions for post-vaccination care.",
        "3. Monitor your dog for any allergic reactions after vaccination.",
        "4. Make sure your dog stays hydrated after vaccination.",
        "5. Schedule annual vaccinations to keep your dog protected.",
      ]
          : [
        "1. Avoid taking your dog to crowded places immediately after vaccination.",
        "2. Plan a calm day at home after vaccination for your dog.",
        "3. Provide soft bedding for your dog to rest after the vaccination.",
        "4. Vaccinate puppies early to help build a strong immune system.",
        "5. Consult your vet if your dog shows signs of discomfort post-vaccination.",
      ];
      break;

    case 'rabbit':
      tips = rabbitClicks % 3 == 0
          ? [
        "1. Rabbits are sensitive to temperature changes post-vaccination.",
        "2. Keep your rabbit in a calm and quiet environment post-vaccination.",
        "3. Provide fresh vegetables to keep your rabbit healthy after vaccination.",
        "4. Monitor your rabbit for any changes in behavior post-vaccination.",
        "5. Make sure your rabbit has a clean space to rest.",
      ]
          : rabbitClicks % 3 == 1
          ? [
        "1. Ensure your rabbit has a balanced diet to support its immune system.",
        "2. Schedule regular vet checkups to ensure your rabbit’s long-term health.",
        "3. Avoid any stressful situations for your rabbit post-vaccination.",
        "4. Check your rabbit for any swelling or redness after vaccination.",
        "5. Keep your rabbit indoors for a few days after the vaccination.",
      ]
          : [
        "1. Vaccinate your rabbit against common diseases like myxomatosis.",
        "2. Provide a warm and quiet area for your rabbit after vaccination.",
        "3. Rabbits can be sensitive to vaccines, so consult your vet if any side effects occur.",
        "4. Keep your rabbit hydrated post-vaccination for quicker recovery.",
        "5. Make sure to follow up with booster shots as recommended by your vet.",
      ];
      break;

    default:
      tips = ["Invalid pet type selected."];
      break;
  }

  return tips;
}