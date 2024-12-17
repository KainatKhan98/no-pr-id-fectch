import 'package:flutter/material.dart';
class PetShop extends StatelessWidget {
  const PetShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          Text('Pet Shop'),
        ],
      ),
    );
  }
}
