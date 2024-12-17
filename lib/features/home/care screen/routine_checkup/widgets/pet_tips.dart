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
        "1. Schedule regular checkups with your vet to monitor your cat's overall health.",
        "2. Keep track of your cat's weight and eating habits during checkups.",
        "3. Regular dental cleanings are important to prevent dental issues.",
        "4. Ensure your cat is up to date with flea and worm treatments.",
        "5. Discuss your cat's diet with your vet for optimal nutrition.",
      ]
          : catClicks % 3 == 1
          ? [
        "1. During checkups, ask your vet about any vaccinations your cat may need.",
        "2. Check your cat's ears regularly for signs of infection or mites.",
        "3. Routine blood tests can help detect underlying health issues early.",
        "4. Discuss behavioral changes with your vet, as they could indicate health issues.",
        "5. Keep a record of your cat's health history to discuss during checkups.",
      ]
          : [
        "1. Ensure your cat's litter box habits are normal, as changes may signal health problems.",
        "2. Keep your cat's claws trimmed to avoid overgrowth or injury.",
        "3. Regularly check your cat's coat for signs of fleas or skin issues.",
        "4. Discuss any unusual behaviors, such as excessive grooming, with your vet.",
        "5. Keep an eye on your cat's hydration levels, especially in hot weather.",
      ];
      break;

    case 'dog':
      tips = dogClicks % 3 == 0
          ? [
        "1. Schedule routine checkups to monitor your dog's health and wellbeing.",
        "2. Check your dog's teeth regularly and ensure proper dental hygiene.",
        "3. Keep your dog's vaccinations up to date during checkups.",
        "4. Monitor your dog's weight and adjust their diet as necessary.",
        "5. Make sure your dog receives regular heartworm and flea prevention treatments.",
      ]
          : dogClicks % 3 == 1
          ? [
        "1. Ask your vet about joint health, especially in older dogs.",
        "2. Keep track of any behavioral changes and report them during checkups.",
        "3. Routine bloodwork can help catch health issues early.",
        "4. Make sure your dog’s coat is clean and free of fleas or ticks.",
        "5. Discuss your dog’s exercise routine with your vet for optimal health.",
      ]
          : [
        "1. Keep your dog's nails trimmed to avoid discomfort or injury.",
        "2. Regular ear checks can prevent infections in dogs, especially those with floppy ears.",
        "3. Ensure your dog's diet is balanced and provides all necessary nutrients.",
        "4. Watch for any signs of discomfort or stiffness in your dog's movement.",
        "5. Keep your dog’s medical records up to date for future checkups.",
      ];
      break;

    case 'rabbit':
      tips = rabbitClicks % 3 == 0
          ? [
        "1. Schedule regular checkups to ensure your rabbit is healthy.",
        "2. Check your rabbit’s teeth regularly, as overgrown teeth can cause health problems.",
        "3. Ensure your rabbit's diet includes plenty of hay to maintain good digestive health.",
        "4. Monitor your rabbit's weight during routine checkups.",
        "5. Discuss any behavioral changes or unusual symptoms with your vet.",
      ]
          : rabbitClicks % 3 == 1
          ? [
        "1. Regularly check your rabbit’s fur for signs of parasites.",
        "2. Ask your vet about nail trimming during routine checkups.",
        "3. Keep your rabbit’s cage clean and sanitized to prevent infections.",
        "4. Discuss your rabbit's diet and any changes in appetite with your vet.",
        "5. Ensure your rabbit is receiving proper vaccinations if necessary.",
      ]
          : [
        "1. Monitor your rabbit’s digestive health and consult your vet if there are changes.",
        "2. Keep your rabbit’s living area free of hazards to prevent injury.",
        "3. Regularly check your rabbit's ears for signs of infection.",
        "4. Discuss dental care options for your rabbit during checkups.",
        "5. Make sure your rabbit gets enough exercise to stay healthy.",
      ];
      break;
  }

  return tips;
}