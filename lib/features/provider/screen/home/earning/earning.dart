import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';

class EarningsOverview extends StatelessWidget {
  const EarningsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Earnings",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          const EarningsCard(
            period: "This Week",
            amount: "\$350",
          ),
          const EarningsCard(
            period: "This Month",
            amount: "\$1500",
          ),
        ],
      ),
    );
  }
}

class EarningsCard extends StatelessWidget {
  final String period;
  final String amount;

  const EarningsCard({super.key, required this.period, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: logoPurple.withOpacity(0.1),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(period, style: Theme.of(context).textTheme.bodyLarge),
            Text(amount, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
