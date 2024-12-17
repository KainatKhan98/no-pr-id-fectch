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
        "1. Keep your cat hydrated and provide fresh water at all times during illness.",
        "2. If your cat shows signs of injury, such as limping, consult your vet immediately.",
        "3. Monitor your cat’s appetite and behavior for signs of illness, such as lethargy.",
        "4. Keep your cat indoors and in a quiet space if they are feeling unwell.",
        "5. Ensure your cat’s wound is clean and dry to prevent infection if they have a minor injury.",
      ]
          : catClicks % 3 == 1
          ? [
        "1. Watch for any changes in your cat’s grooming habits, as this may indicate pain or discomfort.",
        "2. Avoid giving your cat human medication; consult a vet for proper treatment.",
        "3. Use a soft collar to prevent your cat from licking or biting wounds.",
        "4. Regularly check your cat’s paws and claws for any signs of injury.",
        "5. Ensure your cat rests adequately if they have sustained an injury.",
      ]
          : [
        "1. If your cat is vomiting frequently or showing signs of distress, seek veterinary help.",
        "2. Keep an eye on your cat’s breathing pattern for signs of respiratory distress.",
        "3. If your cat has an open wound, keep the area clean and contact your vet for advice on dressing it.",
        "4. Monitor your cat for fever or unusual behavior, as these may be symptoms of illness.",
        "5. Provide a soft bed and warm environment for your cat to recover from injury.",
      ];
      break;

    case 'dog':
      tips = dogClicks % 3 == 0
          ? [
        "1. Keep your dog calm and comfortable if they are showing signs of illness.",
        "2. For minor cuts or scrapes, clean the wound with a vet-approved antiseptic.",
        "3. If your dog is limping or in pain, limit their movement until you can see a vet.",
        "4. Monitor your dog's food and water intake during illness, and encourage hydration.",
        "5. Check your dog’s paws regularly for injuries, especially after outdoor activities.",
      ]
          : dogClicks % 3 == 1
          ? [
        "1. Watch for symptoms like lethargy or loss of appetite, which may indicate illness.",
        "2. Avoid giving your dog human painkillers without consulting a vet.",
        "3. If your dog has a deep cut, wrap the wound and take them to the vet immediately.",
        "4. Apply a cold compress to swollen areas to help reduce inflammation.",
        "5. Keep your dog in a quiet, comfortable space while recovering from illness or injury.",
      ]
          : [
        "1. Use a protective cone to prevent your dog from licking or biting wounds.",
        "2. If your dog has diarrhea or vomiting, ensure they are hydrated and consult a vet if symptoms persist.",
        "3. Keep an eye on your dog’s breathing and heart rate for signs of distress.",
        "4. For sprains or minor injuries, restrict your dog's movement and monitor for improvement.",
        "5. Offer a balanced, soft diet if your dog has difficulty eating due to illness.",
      ];
      break;

    case 'rabbit':
      tips = rabbitClicks % 3 == 0
          ? [
        "1. Monitor your rabbit’s appetite, as a loss of appetite can signal illness.",
        "2. Check your rabbit’s teeth and mouth regularly for signs of dental issues.",
        "3. For minor injuries, clean the affected area and consult your vet for further care.",
        "4. Keep your rabbit in a quiet space if they are unwell or injured to reduce stress.",
        "5. Check your rabbit’s fur for signs of injury or irritation, especially after outdoor play.",
      ]
          : rabbitClicks % 3 == 1
          ? [
        "1. If your rabbit shows signs of lethargy or unusual behavior, consult a vet immediately.",
        "2. Avoid handling your rabbit too much when they are recovering from injury or illness.",
        "3. Keep your rabbit’s nails trimmed to prevent self-injury.",
        "4. Monitor your rabbit for signs of respiratory issues, such as labored breathing.",
        "5. Provide soft bedding to help your rabbit recover comfortably after an injury.",
      ]
          : [
        "1. Ensure your rabbit has access to clean water and soft food during illness.",
        "2. Keep an eye on your rabbit’s fecal output, as changes may indicate digestive problems.",
        "3. For minor wounds, use a vet-recommended antiseptic and keep the area clean.",
        "4. Minimize your rabbit’s physical activity if they are injured, and provide a safe environment for healing.",
        "5. Consult a vet if your rabbit shows signs of stress, such as aggressive behavior or hiding.",
      ];
      break;

    default:
      tips = ["Invalid pet type selected."];
      break;
  }

  return tips;
}