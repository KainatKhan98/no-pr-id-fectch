import 'package:flutter/material.dart';
import 'package:pet/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';

class PetTaxi extends StatelessWidget {
  const PetTaxi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Taxi', style: TextStyle(color: textColor, fontWeight: FontWeight.w500),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                transportSites(context, 'Balance Log ', 'One Stop Solution for Safe & Reliable Logistics Solutions!', 'https://balancelog.com.pk/', 'assets/taxilogos/balance.jpg'),
                SizedBox(height: 10,),
                transportSites(context, 'Costa Logistics', 'Welcome to Costa Logistics Packers & Movers', 'https://www.costa.com.pk/','assets/taxilogos/costalogistics.jpg' ),
                SizedBox(height: 10,),
                transportSites(context, 'Pet Relocation', 'Take Your Friends Where Life Takes You', 'https://www.petrelocation.com/','assets/taxilogos/petrelocation.jpeg' ),
                SizedBox(height: 10,),
                transportSites(context, 'CPI Pet Wings', 'Our First Priority "Everything we do!"', 'https://cpipetswing.com/','assets/taxilogos/petwings.jpg' ),
                SizedBox(height: 10,),
                transportSites(context, 'Islamabad Movers', 'Pet Moving', 'https://islamabadmovers.com/pet-moving/','assets/taxilogos/isbmovers.jpg' ),
                SizedBox(height: 10,),
                transportSites(context, 'Pakistan Movers', 'Anytime Anywhere', 'https://pakistanmovers.com/pets-moving//','assets/taxilogos/pakmovers.jpg' ),
                SizedBox(height: 10,),
                transportSites(context, 'StarCo Logistics', 'Pets Relocation', 'https://www.starcologistics.com.pk/pet-relocation-service/','assets/taxilogos/starco.jpeg' ),
                SizedBox(height: 10,),
                transportSites(context, 'iPATA', 'International Pet and Animal Transportation Association', 'https://www.ipata.org/','assets/taxilogos/ipata.jpeg' ),
                // SizedBox(height: 10,),
                // transportSites(context, 'Costa Logistics', 'Welcome to Costa Logistics Packers & Movers', 'https://www.costa.com.pk/','assets/taxilogos/costalogistics.jpg' ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget transportSites(
      BuildContext context,
      String title,
      String description,
      String url,
      String logoPath
      ) {
    return GestureDetector(
      onTap: () async {
        await _launchUrl(url); // Call the function inside an anonymous function
      },
      child: Container(
        height: 180,
        width: double.infinity, // Adjust width to fill the available space
        decoration: BoxDecoration(
          color: logoPurple,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 3), // Adjust offset as needed
              blurRadius: 5, // Adjust blur radius as needed
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Added spacing between the image and text
              Image(image: AssetImage(logoPath), width: 100, height: 100,),
              // Service details
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () async {
                        await _launchUrl(url); // Call the function here as well
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Set button background color to white
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // Rounded corners
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding for button text
                        child: const Text(
                          "Let's Go",
                          style: TextStyle(
                            color: Colors.black, // Change text color to black
                            fontSize: 16, // Optional: change font size
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url); // Define the uri here
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


}