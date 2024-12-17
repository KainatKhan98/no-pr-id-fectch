import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/constants/sizes.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ratings & Reviews",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          const ReviewCard(
            clientName: "Emily Watson",
            rating: 5,
            comment: "Great service! My dog loved the walk.",
          ),
          const ReviewCard(
            clientName: "Tom Hardy",
            rating: 4,
            comment: "Good grooming, but arrived a little late.",
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String clientName;
  final int rating;
  final String comment;

  const ReviewCard(
      {super.key, required this.clientName, required this.rating, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      color: logoPurple.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(clientName, style: Theme.of(context).textTheme.bodyLarge),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(comment, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
