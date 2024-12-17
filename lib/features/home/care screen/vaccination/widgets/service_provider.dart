import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/circular_image/circular_image.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/images.dart';
import '../../../../provider/controller/service_controller.dart';
import '../../../appointment/descriptionscreen.dart';

class ServiceProvidersSection extends StatefulWidget {
  final ServiceController serviceController;

  const ServiceProvidersSection({required this.serviceController, Key? key}) : super(key: key);

  @override
  _ServiceProvidersSectionState createState() => _ServiceProvidersSectionState();
}

class _ServiceProvidersSectionState extends State<ServiceProvidersSection> {

  @override
  void initState() {
    super.initState();
    widget.serviceController.fetchPetCareServices('Vaccination');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.serviceController.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (widget.serviceController.services.isEmpty) {
        return const Center(child: Text("No services available"));
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.serviceController.services.length,
        itemBuilder: (context, index) {
          final service = widget.serviceController.services[index];
          final networkImage = service.user.profilePicture;
          final image = networkImage.isNotEmpty ? networkImage : avatar;
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(
                      name: service.name,
                      description: service.description,
                      price: service.price,
                      duration: service.durationInMinutes,
                      userName: service.user.fullName,
                      userEmail: service.user.email,
                      profileImageUrl: service.user.profilePicture,
                      providerId: service.providerId,
                    ),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.all(8),
                elevation: 5,  // Adds shadow to the card for a more elevated look
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: textColor,
                    )
                ),
                color: Colors.white,  // Background color of the card
                child: ListTile(
                  // leading: Obx((){
                  //   final networkImage = service.user.profilePicture;
                  //   final image = networkImage.isNotEmpty ? networkImage : avatar;
                  //   return CircularImage(image: image, isNetworkImage: networkImage.isNotEmpty, padding: 0,);
                  // }),
                  leading: CircularImage(image: image, isNetworkImage: networkImage.isNotEmpty, padding: 0,),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),  // Padding inside the ListTile
                  title: Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 20,  // Larger font for the service name
                      fontWeight: FontWeight.bold,
                      color: textColor,  // Dark text color for better readability
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),  // Padding to separate subtitle text from title
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User: ${service.user.fullName}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,  // Lighter text color for the user's name
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Price: ',  // This will be in black
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,  // Black color for "Price"
                                ),
                              ),
                              TextSpan(
                                text: '\$${service.price.toString()}',  // This will be in green
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,  // Green color for the actual price
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          'Duration: ${service.durationInMinutes} mins',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,  // Slightly lighter text for duration
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Icon(
                    service.isAvailable ? Icons.check_circle : Icons.cancel,
                    color: service.isAvailable ? Colors.green : Colors.red,  // Green for available, red for unavailable
                    size: 28,  // Icon size
                  ),
                ),
              )
          );
        },
      );
    });
  }
}
