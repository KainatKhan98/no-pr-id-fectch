import 'package:flutter/material.dart';
import 'package:pet/constants/colors.dart';
import 'package:pet/constants/sizes.dart';

class ChangeEmail extends StatelessWidget {
  final String email;

  const ChangeEmail({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Email Details', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('This is your current Email. You cannot change the email.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: Sizes.s*2,),

            // Text Fields
            TextField(
              controller: TextEditingController(text: email),
              readOnly: true,
              maxLines: null,
              style: TextStyle(color: textColor.withOpacity(0.5),fontSize: 14),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ],
        ),
      ),
    );
  }
}