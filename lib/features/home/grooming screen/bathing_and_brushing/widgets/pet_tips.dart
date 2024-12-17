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
        "1. Use a gentle cat shampoo specifically designed for cats to avoid skin irritation.",
        "2. Brush your cat before bathing to remove loose fur and prevent matting.",
        "3. Make bath time stress-free by using a non-slip mat in the tub or sink.",
        "4. Ensure the water temperature is lukewarm to keep your cat comfortable.",
        "5. Rinse thoroughly to remove all shampoo, as any residue can irritate the skin.",
      ]
          : catClicks % 3 == 1
          ? [
        "1. Use a soft brush to avoid scratching your cat's skin during grooming.",
        "2. Introduce your cat to water gradually; some cats may need time to adjust.",
        "3. Dry your cat gently with a towel and avoid using a hairdryer, as it can scare them.",
        "4. Bathe your cat only when necessary, as too much bathing can strip natural oils.",
        "5. Reward your cat with treats or praise after bath time to create a positive experience.",
      ]
          : [
        "1. Focus on brushing areas where mats are likely to form, like behind the ears and under the legs.",
        "2. Use a grooming glove or brush designed for short-haired cats for effective brushing.",
        "3. Keep the bathing area calm and quiet to help your cat feel secure.",
        "4. Use cotton balls in your cat's ears to prevent water from entering during baths.",
        "5. If your cat shows extreme dislike for water, consider using dry shampoo or grooming wipes.",
      ];
      break;

    case 'dog':
      tips = dogClicks% 3 == 0
          ? [
        "1. Choose a dog shampoo that suits your dog's skin type; consult your vet if unsure.",
        "2. Brush your dog before bathing to remove loose hair and prevent clogs in the drain.",
        "3. Use a handheld showerhead or cup to rinse your dog thoroughly.",
        "4. Always check the water temperature; it should be warm but not hot.",
        "5. Keep bath time short to avoid stressing your dog.",
      ]
          : dogClicks % 3 == 1
          ? [
        "1. For dogs with long fur, use a detangling spray to ease brushing and remove knots.",
        "2. Brush your dog regularly, especially during shedding seasons, to minimize loose fur.",
        "3. Reward your dog with treats during and after bathing to create a positive association.",
        "4. Dry your dog with a towel and, if they tolerate it, a low-speed hairdryer.",
        "5. Ensure the bathing area is safe; use non-slip mats to prevent slipping.",
      ]
          : [
        "1. Avoid bathing your dog too often; it can dry out their skin. Every 4-6 weeks is usually enough.",
        "2. Brush your dog gently and with the direction of hair growth to avoid discomfort.",
        "3. Make bath time enjoyable by playing with your dog or using their favorite toys.",
        "4. Consider using a pet-specific ear cleaner to keep their ears clean and dry.",
        "5. If your dog is anxious about baths, practice desensitization techniques beforehand.",
      ];
      break;

    case 'rabbit':
      tips = rabbitClicks % 3 == 0
          ? [
        "1. Rabbits generally don’t need baths; spot clean any dirty areas with a damp cloth.",
        "2. Use a soft brush to remove loose fur and prevent matting.",
        "3. If your rabbit gets wet, dry them thoroughly with a towel and keep them warm.",
        "4. Avoid submerging your rabbit in water, as it can cause stress and health issues.",
        "5. Regular grooming helps maintain a healthy coat and reduces shedding.",
      ]
          : rabbitClicks % 3 == 1
          ? [
        "1. Use a brush designed for small animals to ensure gentle grooming.",
        "2. Check your rabbit's nails regularly and trim them if necessary to avoid injuries.",
        "3. If your rabbit is dirty, consider using dry shampoo formulated for rabbits.",
        "4. Create a calm environment during grooming to reduce stress.",
        "5. Always supervise your rabbit during bathing or grooming sessions.",
      ]
          : [
        "1. Get your rabbit used to handling by gently petting them before brushing.",
        "2. Never use human shampoo or soap; it can irritate your rabbit's skin.",
        "3. Keep grooming sessions short and positive to build trust.",
        "4. Reward your rabbit with treats after grooming to encourage good behavior.",
        "5. If your rabbit has a serious mess, consult a vet for the best cleaning approach.",
      ];
      break;

    default:
      tips = ["Invalid pet type selected."];
      break;
  }

  return tips;
}