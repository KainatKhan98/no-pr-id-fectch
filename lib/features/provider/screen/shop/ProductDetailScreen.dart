import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  final String vendorId;

  const ProductDetailScreen({super.key, 
    required this.productId,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.vendorId,
  });

  Future<void> _deleteProduct(BuildContext context) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmDelete) {
      try {
        // Delete the product from Firestore
        await FirebaseFirestore.instance.collection('products').doc(productId).delete();

        // Navigate back to "My Shop" screen after deletion
        Get.back();
        Get.snackbar('Success', 'Product deleted successfully',
            snackPosition: SnackPosition.BOTTOM);
      } catch (error) {
        print('Error deleting product: $error');
        Get.snackbar('Error', 'Failed to delete product',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35, // 40% of screen height
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(

              'Title: $title',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: RS ${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _deleteProduct(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete Product'),
            ),
          ],
        ),
      ),
    );
  }
}
