import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  final String vendorId;

  const AddProductScreen({super.key, required this.vendorId});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  String _title = '';
  double _price = 0.0;
  String _description = '';
  File? _image;
  bool _isLoading = false;
  bool _imagePicked = true; // Track if image is picked

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imagePicked = true; // Mark image as picked
      }
    });
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String? imageUrl;
        if (_image != null) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference storageRef = FirebaseStorage.instance.ref().child('products/$fileName');
          UploadTask uploadTask = storageRef.putFile(_image!);
          TaskSnapshot snapshot = await uploadTask;
          imageUrl = await snapshot.ref.getDownloadURL();
        }

        DocumentReference productRef = FirebaseFirestore.instance.collection('products').doc();
        await productRef.set({
          'id': productRef.id,
          'vendorId': widget.vendorId,
          'title': _title,
          'category': _category,
          'price': _price,
          'description': _description,
          'imageUrl': imageUrl,
        });

        Get.back(result: _category);
      } catch (error) {
        print('Error adding product: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      if (_image == null) {
        setState(() {
          _imagePicked = false; // Mark image as not picked
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _category,
                  hint: const Text('Select Category'),
                  onChanged: (newValue) => setState(() => _category = newValue),
                  items: const [
                    DropdownMenuItem(value: 'Pet Food', child: Text('Pet Food')),
                    DropdownMenuItem(value: 'Accessories', child: Text('Accessories')),
                    DropdownMenuItem(value: 'Clothing', child: Text('Clothing')),
                    DropdownMenuItem(value: 'Hygiene & Grooming Tools', child: Text('Hygiene & Grooming Tools')),
                  ],
                  validator: (value) => value == null ? 'Please select a category' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Product Title'),
                  onChanged: (value) => _title = value,
                  validator: (value) => value!.isEmpty ? 'Title is required' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _price = double.tryParse(value) ?? 0.0,
                  validator: (value) => value!.isEmpty ? 'Price is required' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onChanged: (value) => _description = value,
                  validator: (value) => value!.isEmpty ? 'Description is required' : null,
                ),
                SizedBox(height: 20),

                // Display image container
                Container(
                  height: 220,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2), // Black border
                    color: Colors.transparent, // Transparent background
                  ),
                  child: _image == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center Pick Image button
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Pick Image'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, // Black text color
                          backgroundColor: Colors.transparent, // Transparent button background
                          shadowColor: Colors.transparent, // No shadow
                        ),
                      ),
                    ],
                  )
                      : Image.file(_image!),
                ),

                if (_image == null && !_imagePicked) // Display error if image not picked
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'No image selected.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                SizedBox(height: 20),

                // Add Product Button (always visible)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15)),
                  onPressed: _addProduct,
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
