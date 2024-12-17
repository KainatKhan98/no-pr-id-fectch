import 'package:flutter/material.dart';
import 'package:pet/constants/images.dart';

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
        "Use a de-shedding tool designed specifically for cats to reduce loose hair.",
        "Regular brushing helps prevent matting and keeps your cat's coat smooth.",
        "If your cat's hair is prone to matting, consider a professional trim to avoid discomfort.",
        "During shedding season, increase the frequency of brushing to manage loose fur.",
        "Avoid cutting your cat's hair at home unless you're experienced; consult a groomer for trims.",
      ]
          : catClicks % 3 == 1
          ? [
        "For long-haired cats, focus on de-shedding tools that reach undercoats without damaging top fur.",
        "Give your cat a haircut if their fur becomes too long or tangled, but seek professional grooming advice first.",
        "If you notice excessive shedding, consult your vet to rule out any health issues.",
        "Use grooming gloves to gently remove loose fur during de-shedding.",
        "Regular trims can help prevent fur from becoming unmanageable, especially in hot weather.",
      ]
          : [
        "When de-shedding, focus on areas like the belly and behind the ears, where fur tends to mat easily.",
        "Use a thinning shear to remove excess hair without causing discomfort during grooming.",
        "For cats that dislike grooming, break the session into smaller intervals.",
        "Ensure that your grooming tools are appropriate for your cat's fur length and texture.",
        "For heavily matted fur, professional grooming might be necessary to avoid hurting your cat.",
      ];
      break;

    case 'dog':
      tips = dogClicks % 3 == 0
          ? [
        "De-shedding tools with fine bristles help remove your dog's loose undercoat without irritation.",
        "Regular haircuts for long-haired dogs help maintain their coats and reduce shedding.",
        "Focus on areas where your dog tends to shed the most, like their back and sides.",
        "Keep your dog comfortable during haircuts by using clippers with adjustable blade lengths.",
        "Consider professional grooming for complex haircuts or large dogs to ensure safety and quality.",
      ]
          : dogClicks% 3 == 1
          ? [
        "During shedding season, brush your dog daily to manage loose hair and avoid mats.",
        "Professional haircuts can help keep your dog cool in warm weather and reduce shedding.",
        "Use de-shedding shampoos or treatments to minimize loose fur during baths.",
        "Haircuts should always match the breed’s coat type; ask your groomer for advice if unsure.",
        "For dogs with heavy shedding, a professional de-shedding treatment might be the best option.",
      ]
          : [
        "Regular haircuts help maintain coat health and reduce shedding in dogs with thick or long fur.",
        "Always use scissors and clippers designed for dog grooming to avoid accidental cuts.",
        "To manage shedding, consider using a high-velocity dryer after baths to remove loose fur.",
        "Focus on high-shed areas like the neck, chest, and tail when using de-shedding tools.",
        "If your dog is shedding excessively, consult a vet to check for underlying health conditions.",
      ];
      break;

    case 'rabbit':
      tips = rabbitClicks % 3 == 0
          ? [
        "Use a soft de-shedding tool to remove loose fur from your rabbit’s coat.",
        "Trim any overgrown fur, especially in long-haired rabbits, to avoid tangling and matting.",
        "During shedding season, brush your rabbit more frequently to manage loose hair.",
        "Keep the grooming process gentle to prevent stress; rabbits can be sensitive during de-shedding.",
        "For excessive fur growth, a light trim may be necessary, but always consult a vet or groomer before cutting.",
      ]
          : rabbitClicks % 3 == 1
          ? [
        "Use a soft brush to gently de-shed your rabbit without pulling on their delicate skin.",
        "Trimming excess fur around the rear and belly can help with hygiene and prevent matting.",
        "During heavy shedding periods, daily brushing is recommended to avoid fur buildup.",
        "If your rabbit's fur is long, consider professional grooming to prevent tangles.",
        "Make sure your rabbit feels safe during grooming to avoid stress; calm environments work best.",
      ]
          : [
        "For rabbits with long fur, use blunt-nose scissors to carefully trim areas prone to matting.",
        "A regular de-shedding routine helps maintain your rabbit’s fur health and reduces loose fur.",
        "Trimming fur around sensitive areas, like the rear, can help keep your rabbit clean and comfortable.",
        "If your rabbit is shedding excessively, check their diet or environment for stressors.",
        "Always avoid over-grooming, which can cause skin irritation and stress in rabbits.",
      ];
      break;

    default:
      tips = ["Invalid pet type selected."];
      break;
  }

  return tips;
}