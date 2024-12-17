import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet/constants/colors.dart';

import 'AddProductScreen.dart';
import 'ProductDetailScreen.dart'; // Import the ProductDetailScreen

class MyShopScreen extends StatefulWidget {
  const MyShopScreen({super.key});

  @override
  _MyShopScreenState createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  String _selectedCategory = 'All'; // Default category to show all products
  String _searchQuery = ''; // Variable to hold the search query

  // Fetch products based on selected category and search query
  Stream<QuerySnapshot> getProductsByCategory(String category) {
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    // Build the query
    Query query = products;

    if (category != 'All') {
      query = query.where('category', isEqualTo: category);
    }

    // If there is a search query, add a where clause for the title
    if (_searchQuery.isNotEmpty) {
      query = query.where('title', isGreaterThanOrEqualTo: _searchQuery)
          .where('title', isLessThanOrEqualTo: '$_searchQuery\uf8ff'); // Add a suffix to match full word
    }

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: logoPurple,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("My Products", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              // Navigate to AddProductScreen to add new products
              final result = await Get.to(() => AddProductScreen(vendorId: 'vendor_id'));
              if (result != null) {
                // Update selected category if a new product is added
                setState(() {
                  _selectedCategory = result;
                });
              }
            },
            icon: Container(
              height: 50,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(Icons.add, color: textColor, size: 30),
            ),
            label: const Text('',),
          ),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.blue),
      //         child: Text(' Products \n Categories', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
      //       ),
      //       ListTile(
      //         title: const Text('All'),
      //         onTap: () => setState(() => _selectedCategory = 'All'), // Show all products
      //       ),
      //       ListTile(
      //         title: const Text('Pet Food'),
      //         onTap: () => setState(() => _selectedCategory = 'Pet Food'),
      //       ),
      //       ListTile(
      //         title: const Text('Accessories'),
      //         onTap: () => setState(() => _selectedCategory = 'Accessories'),
      //       ),
      //       ListTile(
      //         title: const Text('Clothing'),
      //         onTap: () => setState(() => _selectedCategory = 'Clothing'),
      //       ),
      //       ListTile(
      //         title: const Text('Hygiene & Grooming Tools'),
      //         onTap: () => setState(() => _selectedCategory = 'Hygiene & Grooming Tools'),
      //       ),
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // Update search query
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: const BorderSide(
                    color: textColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: const BorderSide(
                    color: textColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: const BorderSide(
                    color: textColor,
                    width: 1.5,
                  ),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
            padding: EdgeInsets.all(20),
              decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: getProductsByCategory(_selectedCategory),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  // Display products in a grid view
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var productData = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to ProductDetailScreen on tap
                          Get.to(() => ProductDetailScreen(
                            productId: productData.id,
                            title: productData['title'],
                            price: productData['price'],
                            description: productData['description'],
                            imageUrl: productData['imageUrl'],
                            vendorId: productData['vendorId'],
                          ));
                        },
                        // child: Card(
                        //   color: Colors.white,
                        //   child: Column(
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.all(10.0),
                        //         child: Image.network(
                        //           productData['imageUrl'],
                        //           height: screenHeight * 0.12,
                        //           width: double.infinity,
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             // Flexible Text widget to handle long titles
                        //             Flexible(
                        //               child: Text(
                        //                 productData['title'],
                        //                 style: const TextStyle(fontWeight: FontWeight.bold, color: textColor),
                        //                 maxLines: 1,
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 5),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             Flexible(
                        //
                        //               child: Text(
                        //                 'RS: ${productData['price'].toString()}',
                        //                 style: const TextStyle(color: Colors.redAccent),
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        child: SizedBox(
                          height: 200,
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    productData['imageUrl'],
                                    height: screenHeight * 0.12, // Adjusted height
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Title
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    productData['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: textColor, // Changed color to black for visibility
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center, // Center align title
                                  ),
                                ),
                                const SizedBox(height: 8), // Space between title and price

                                // Price
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'RS: ${productData['price'].toString()}',
                                          style: const TextStyle(color: Colors.redAccent),
                                          textAlign: TextAlign.center,
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
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
