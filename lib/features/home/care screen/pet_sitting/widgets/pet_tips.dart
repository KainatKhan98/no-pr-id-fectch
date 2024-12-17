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
        "1. Use a harness instead of a collar for safer outdoor walks.",
        "2. Start with short walks to help your cat get used to being outside.",
        "3. Choose a quiet, safe area for walks, away from loud noises and traffic.",
        "4. Bring treats to reward your cat for good behavior during walks.",
        "5. Keep an eye on your cat for signs of stress, and cut the walk short if needed.",
      ]
          : catClicks % 3 == 1
          ? [
        "1. Train your cat to walk on a leash indoors before venturing outside.",
        "2. Always supervise your cat while walking to ensure their safety.",
        "3. Avoid letting your cat interact with strange animals during walks.",
        "4. Bring water along on hot days to keep your cat hydrated.",
        "5. Ensure your cat is up to date on vaccinations before taking them outside.",
      ]
          : [
        "1. Use a lightweight leash that won’t weigh your cat down.",
        "2. Look for signs of fatigue and take breaks as needed during walks.",
        "3. Make sure your cat is comfortable with the harness before walking.",
        "4. Avoid busy streets and areas with a lot of foot traffic.",
        "5. Monitor your cat’s paws for signs of irritation or injury after walks.",
      ];
      break;

    case 'dog':
      tips = dogClicks % 3 == 0
          ? [
        "1. Use a sturdy collar and leash for better control while walking.",
        "2. Take your dog on daily walks to help them stay healthy and happy.",
        "3. Always clean up after your dog to keep public spaces clean.",
        "4. Teach your dog basic commands like 'sit' and 'stay' for better behavior during walks.",
        "5. Bring water and treats along to keep your dog hydrated and motivated.",
      ]
          : dogClicks % 3 == 1
          ? [
        "1. Choose a suitable walking route that matches your dog’s energy level.",
        "2. Be mindful of the weather; avoid walking on hot pavement during summer.",
        "3. Use reflective gear during evening walks for safety.",
        "4. Avoid distractions like other dogs or wildlife to keep your dog focused.",
        "5. Gradually increase walk length to build your dog’s stamina.",
      ]
          : [
        "1. Incorporate playtime or training exercises during walks for mental stimulation.",
        "2. Use a comfortable harness for large breeds to prevent pulling.",
        "3. Schedule regular vet checkups to ensure your dog is fit for walking.",
        "4. Avoid overly crowded areas where your dog might feel anxious.",
        "5. Encourage good leash manners to prevent pulling and jumping.",
      ];
      break;

    case 'rabbit':
      tips = rabbitClicks % 3 == 0
          ? [
        "1. Use a secure carrier for transporting your rabbit to a safe walking area.",
        "2. Start with short outdoor sessions to help your rabbit acclimate.",
        "3. Always supervise your rabbit during walks to prevent escape.",
        "4. Look for rabbit-friendly parks or quiet gardens for a safe walking environment.",
        "5. Ensure the ground is soft and safe for your rabbit’s sensitive paws.",
      ]
          : rabbitClicks % 3 == 1
          ? [
        "1. Avoid walking your rabbit on hot or hard surfaces to protect their paws.",
        "2. Use a harness designed for rabbits to keep them secure during walks.",
        "3. Allow your rabbit to explore at their own pace and avoid forcing them.",
        "4. Keep an eye out for any signs of distress and cut the walk short if necessary.",
        "5. Make sure your rabbit is up to date on vaccinations before taking them outside.",
      ]
          : [
        "1. Create a safe space in your yard where your rabbit can explore freely.",
        "2. Train your rabbit to respond to your commands for better control.",
        "3. Avoid areas with a lot of dogs or other potential stressors for your rabbit.",
        "4. Monitor your rabbit's behavior and comfort level during walks.",
        "5. Provide fresh greens or treats to reward your rabbit after the walk.",
      ];
      break;
  }

  return tips;
}