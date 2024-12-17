import 'package:flutter/material.dart';

class ProviderCard extends StatelessWidget {
  final String providerName;
  final String serviceName;
  final String rating;
  final String picture;

  const ProviderCard({
    super.key,
    required this.providerName,
    required this.serviceName,
    required this.rating,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(picture), // Use AssetImage for local images
            backgroundColor: Colors.grey[200], // Fallback if image fails to load
          ),
          const SizedBox(width: 12.0),

          // Text Content (Name, Service, Rating)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Provider Name
                Text(
                  providerName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Service Name
                Text(
                  serviceName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Rating
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                rating,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
