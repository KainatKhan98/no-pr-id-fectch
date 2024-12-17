import 'package:flutter/material.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/features/home/care%20screen/dental/widgets/pet_tips.dart';
import 'package:pet/features/home/care%20screen/dental/widgets/service_provider.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/sizes.dart';
import '../../../provider/controller/service_controller.dart';
import '../widgets/header_image.dart';
import '../widgets/pet_type_selector.dart';
import 'package:get/get.dart';

class DentalCare extends StatefulWidget {
  const DentalCare({super.key});

  @override
  State<DentalCare> createState() => _DentalCareState();
}

class _DentalCareState extends State<DentalCare> {
  String? selectedPet;
  int currentPageIndex = 0;
  int catClickCount = 0; // Counter for Cat clicks
  int dogClickCount = 0; // Counter for Dog clicks
  int rabbitClickCount = 0;
  bool isCatLoading = false;  // Track loading state for Cat
  bool isDogLoading = false;  // Track loading state for Dog
  bool isRabbitLoading = false;

  final ServiceController serviceController = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dental care', style: TextStyle(color: textColor, fontWeight: FontWeight.w500),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor:Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PetImageHeader(headerImage: dental,),
              SizedBox(height: Sizes.m),
              Text('Select Pet Type', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: Sizes.s),
              RichText(
                text: const TextSpan(
                  text: 'Note: ', style: TextStyle(color: Colors.red,fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Selecting a pet type helps us provide the most relevant vaccination tips for your pet.',style: body
                    ),
                  ],
                ),
              ),
              SizedBox(height: Sizes.m),
              PetTypeSelector(
                onPetSelected: _handlePetSelection,
                isCatLoading: isCatLoading,
                isDogLoading: isDogLoading,
                isRabbitLoading: isRabbitLoading,
              ),
              const SizedBox(height: 20),
              if (selectedPet != null)
                PetTipsSection(
                  petType: selectedPet!,
                  catClickCount: catClickCount,
                  dogClickCount: dogClickCount,
                  rabbitClickCount: rabbitClickCount,
                ),
              SizedBox(height: Sizes.defaultPadding),
              Text('Nearby Service Providers', style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: Sizes.defaultPadding),
              ServiceProvidersSection(
                serviceController: serviceController,
              ),
            ],
          ),
        ),
      ),
    );

  }
  void _handlePetSelection(String pet) {
    setState(() {
      if (pet == 'cat') {
        isCatLoading = true;
      } else if (pet == 'dog') {
        isDogLoading = true;
      } else if (pet == 'rabbit') {
        isRabbitLoading = true;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        selectedPet = pet;
        if (pet == 'cat') {
          catClickCount++;
          isCatLoading = false;
        } else if (pet == 'dog') {
          dogClickCount++;
          isDogLoading = false;
        } else if (pet == 'rabbit') {
          rabbitClickCount++;
          isRabbitLoading = false;
        }
      });
    });
  }

}

