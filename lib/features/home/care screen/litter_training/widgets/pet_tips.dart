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
        "1. Choose a spacious litter box that allows your cat to move around comfortably.",
        "2. Use unscented, clumping litter for better absorption and easy cleaning.",
        "3. Place the litter box in a quiet, low-traffic area to provide privacy.",
        "4. Show your cat where the litter box is, especially after meals or naps.",
        "5. Keep the litter box clean by scooping daily and changing the litter regularly.",
      ]
          : catClicks % 3 == 1
          ? [
        "1. Reward your cat with treats or praise immediately after they use the litter box.",
        "2. Avoid using strong fragrances or cleaning products near the litter box.",
        "3. If your cat refuses to use the box, try a different type of litter or box.",
        "4. Ensure the litter box is accessible at all times, especially for older cats.",
        "5. Monitor your cat’s behavior; if they show signs of reluctance, consult a vet.",
      ]
          : [
        "1. Avoid punishing your cat for accidents outside the litter box; remain patient.",
        "2. Place multiple litter boxes in different locations if you have a multi-story home.",
        "3. If your cat is newly adopted, allow time for adjustment to their new environment.",
        "4. Check the litter depth; some cats prefer a shallow layer of litter.",
        "5. Regularly check for any health issues if your cat suddenly stops using the litter box.",
      ];
      break;

    case 'dog':
      tips = dogClicks % 3 == 0
          ? [
        "1. Use a designated potty area outside to help your dog associate it with bathroom breaks.",
        "2. Take your dog out frequently, especially after meals, playtime, or naps.",
        "3. Reward your dog with treats and praise immediately after they relieve themselves outside.",
        "4. Supervise your dog indoors to catch any signs that they need to go out.",
        "5. Keep a consistent schedule for potty breaks to reinforce the routine.",
      ]
          : dogClicks % 3 == 1
          ? [
        "1. If your dog has an accident indoors, clean it up thoroughly to eliminate odors.",
        "2. Use a specific command, like 'go potty,' to help your dog understand what to do.",
        "3. Consider using training pads if you cannot take your dog outside frequently.",
        "4. Be patient; accidents are normal during the training process.",
        "5. Gradually increase the time between potty breaks as your dog gets better at using the designated area.",
      ]
          : [
        "1. If your dog seems hesitant to go outside, ensure they feel safe and comfortable.",
        "2. Avoid punishing your dog for accidents; this can create fear and confusion.",
        "3. Keep the potty area clean to encourage your dog to use it regularly.",
        "4. If your dog consistently refuses to go outside, consult a vet for potential underlying issues.",
        "5. Celebrate successes; positive reinforcement is key to effective training.",
      ];
      break;

    case 'rabbit':
      tips = rabbitClicks % 3 == 0
          ? [
        "1. Use a spacious litter box that is easy for your rabbit to enter and exit.",
        "2. Choose a litter that is safe for rabbits, like paper-based or aspen bedding.",
        "3. Place the litter box in a corner where your rabbit tends to go to the bathroom.",
        "4. Clean the litter box regularly to encourage your rabbit to use it consistently.",
        "5. Allow your rabbit to explore and sniff the litter box to familiarize them with it.",
      ]
          : rabbitClicks % 3 == 1
          ? [
        "1. If your rabbit has an accident, clean it up promptly and avoid scolding.",
        "2. Observe your rabbit's behavior to identify their preferred potty area.",
        "3. Provide multiple litter boxes in different areas if your rabbit has a large space.",
        "4. Reward your rabbit with treats or praise when they use the litter box correctly.",
        "5. Be patient; it may take time for your rabbit to get used to the litter box.",
      ]
          : [
        "1. Gradually introduce your rabbit to the litter box to reduce anxiety.",
        "2. Monitor your rabbit’s health; changes in litter box habits can indicate issues.",
        "3. Keep the litter box clean to encourage consistent use.",
        "4. Use small amounts of hay in the litter box to make it more appealing to your rabbit.",
        "5. Ensure your rabbit feels safe and secure in their environment to promote good litter habits.",
      ];
      break;

    default:
      tips = ["Invalid pet type selected."];
      break;
  }

  return tips;
}