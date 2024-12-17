import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/constants/sizes.dart';
import 'package:pet/features/provider/model/service_model.dart';
import 'package:pet/features/provider/screen/home/services/widgets/add_service.dart';
import 'package:pet/features/provider/screen/home/services/widgets/edit_service-page.dart';
import '../../../controller/service_controller.dart';

class ServiceOverview extends StatelessWidget {
  final String providerId; // Pass providerId to fetch specific provider services

  const ServiceOverview({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final ServiceController controller = Get.put(ServiceController());

    // Fetch services for the provider
    controller.fetchServices(providerId);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: Sizes.defaultPadding, left: Sizes.defaultPadding),
          child: Obx(() {
            // Observe the services list to check if it's empty or not
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("My Services", style: Theme.of(context).textTheme.headlineSmall),
                  controller.services.isEmpty
                      ? Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildAddServiceButton(),
                    ],
                  )
                      : Column(
                    children: [
                      _buildServicesList(controller.services), // Show updated list of services
                      const SizedBox(height: 20),
                      _buildAddServiceButton(),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // Builds the services list
  Widget _buildServicesList(List<ServiceModel> services) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: services.length, // Number of services
      itemBuilder: (context, index) {
        final service = services[index];
        return Card(
          color: logoPurple.withOpacity(0.1),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Rs.${service.price} | ${service.durationInMinutes} minutes',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Switch(
                      value: service.isAvailable,
                      onChanged: (value) {
                        // Toggle availability action
                        // Call controller to update service availability
                      },
                      activeColor: logoPurple,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: logoPurple),
                      onPressed: () {
                        // Edit service action
                        Get.to(() => EditServicePage(service: service));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Builds the "Add New Service" button
  Widget _buildAddServiceButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // Add new service action
          Get.to(() => AddServicePage());
        },
        icon: const Icon(Icons.add),
        label: const Text('Add New Service'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
